# Class which populates the table for the IP addresses using either JSON or HTML.
# This class includes the Options such as Show, Edit, Destroy, Create, New and Update

class IpAddressesController < ApplicationController

	before_filter :session_update

  # GET /ip_addresses
  # GET /ip_addresses.json
  def index
    @ip_addresses = IpAddress.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ip_addresses }
    end
  end

	# POST /ip/networkParents
	def networkParents
    respond_to do |format|
      format.json { render json: Network.ip_in_range?(params[:ip]) }
    end
	end

	# POST /ip/macCheck.json
	def macCheck
		resp_val = IpAddress.where("mac_address = '#{params[:mac]}'").length == 0
    respond_to do |format|
      format.json { render json: resp_val }
    end
	end

	# POST /ip/dataTable.json
	def dataTable
		s = params[:sSearch]
		if(s.match(/[\d]{1,3}\./))
			while s.match(/[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}/).nil?
				s += "0."
			end
			s += "0."
			s.chop!
			d = s.gsub(".0",".255")
			s = IP.parse(s)
			d = IP.parse(d)
			ip_addresses = IpAddress.where("ip_v4 > '#{s.to_hex}' AND ip_v4 < '#{d.to_hex}'")
			total = ip_addresses.length
			ip_addresses = ip_addresses[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
		elsif(s.match /[0-9a-fA-F]{0,4}:/)
			while s.match(/([0-9a-fA-F]{0,4}:){7}/).nil?
				s += "0000:"
			end
			s += "0000:"
			s.chop!
			d = s.gsub(":0000",":FFFF")
			s = IP.parse(s)
			d = IP.parse(d)
			ip_addresses = IpAddress.where("ip_v6 > '#{s.to_hex}' AND ip_v6 < '#{d.to_hex}'")
			total = ip_addresses.length
			ip_addresses = ip_addresses[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
		elsif s.match(/.+/)
			ip_addresses = IpAddress.joins(:network).where(
				"contact LIKE \"#{s}%\" OR location LIKE \"#{s}%\" OR networks.name LIKE \"#{s}%\""
				)
			total = ip_addresses.length
			ip_addresses = ip_addresses[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
		else
			ip_addresses = IpAddress.joins(:network).all[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
			total = IpAddress.count
		end
		aaData = []
		ip_addresses.each do |ip|
			aaData.push [ ip.contact, ip.location, (ip.type.nil?)?"None":ip.type.name,
				(ip.network.nil?)?"None":[ip.network.id,ip.network.name], ip.is_static_dhcp,
				(ip.dns_devices.nil?)?"None":(ip.dns_devices.collect {|x| x.name}.join ", "),  # filter object names into array - collapse array into string
				ip.ip_str, ip.id]
		end
		resp_val = { :sEcho => params[:sEcho].to_i.to_s, :iTotalRecords => IpAddress.all.count, :iTotalDisplayRecords => total,
			 :aaData => aaData } 

    respond_to do |format|
      format.json { render json: resp_val }
    end
	end

  # GET /ip_addresses/1
  # GET /ip_addresses/1.json
  def show
    @ip_address = IpAddress.find(params[:id])
		@assocs = DnsDeviceAssoc.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ip_address }
    end
  end

  # GET /ip_addresses/new
  # GET /ip_addresses/new.json
  def new
    @ip_address = IpAddress.new
		@dns_device = @ip_address.dns_devices.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ip_address }
    end
  end

  # GET /ip_addresses/1/edit
  def edit
    @ip_address = IpAddress.find(params[:id])
  end

  # POST /ip_addresses
  # POST /ip_addresses.json
  def create
		params[:ip_address][:dns_devices].delete ""
		params[:ip_address][:dns_devices] = params[:ip_address][:dns_devices].collect{|x| {:name => x}}
		models =  DnsDeviceAssoc.where('name IN ("'+params[:ip_address][:dns_devices].collect{|x| x[:name]}.join("\", \"")+'")')

		params[:ip_address].delete :dns_devices
    @ip_address = IpAddress.new(params[:ip_address])
		validity = @ip_address.valid_ip? :new
    respond_to do |format|
      if validity && @ip_address.save
				DnsIpJoin.transaction do
					models.each {|dns| DnsIpJoin.create({:ip_id => @ip_address.id, :dns_id => dns.id})}
				end
        format.html { redirect_to @ip_address, notice: 'Ip address was successfully created.' }
        format.json { render json: @ip_address, status: :created, location: @ip_address }
			elsif !validity
        format.html { render action: "new", notice: 'IP Address invalid.  Be sure that the parent network contains this address and that the address is not already assigned.' }
        format.json { render json: @ip_address.errors, status: :unprocessable_entity }
      else
        format.html { render action: "new", notice: 'IP Address could not be saved' }
        format.json { render json: @ip_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ip_addresses/1
  # PUT /ip_addresses/1.json
  def update
    @ip_address = IpAddress.find(params[:id])
		params[:ip_address][:dns_devices].delete ""
		comp = @ip_address.dns_devices.collect {|x| x.name}
		params[:ip_address][:dns_devices] = params[:ip_address][:dns_devices].collect{|x| comp.delete(x); {:name => x}}
		models =  DnsDeviceAssoc.where('name IN ("'+params[:ip_address][:dns_devices].collect{|x| x[:name]}.join("\", \"")+'")')
		params[:ip_address][:dns_devices] = params[:ip_address][:dns_devices].concat(comp.collect{|x| {:name => x, :_destroy => "1"}})
		DnsIpJoin.transaction do
			DnsIpJoin.destroy_all(:ip_id => @ip_address.id)
			models.each {|dns| DnsIpJoin.create({:ip_id => @ip_address.id, :dns_id => dns.id})}
		end
		params[:ip_address].delete :dns_devices
    respond_to do |format|
      if @ip_address.valid_ip?(:update) && @ip_address.update_attributes(params[:ip_address])
        format.html { redirect_to @ip_address, notice: 'Ip address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ip_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ip_addresses/1
  # DELETE /ip_addresses/1.json
  def destroy
    @ip_address = IpAddress.find(params[:id])
    @ip_address.destroy

    respond_to do |format|
      format.html { redirect_to ip_addresses_url }
      format.json { head :no_content }
    end
  end
end
