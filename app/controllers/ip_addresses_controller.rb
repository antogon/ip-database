class IpAddressesController < ApplicationController
  # GET /ip_addresses
  # GET /ip_addresses.json
  def index
    @ip_addresses = IpAddress.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ip_addresses }
    end
  end

	# GET /ip/dataTable.json
	def dataTable
		ip_addresses = IpAddress.where(:id => params[:iDisplayStart]..(params[:iDisplayStart]+params[:iDisplayLength]))
		aaData = []
		ip_addresses.each do |ip|
			aaData.push [ ip.contact, ip.location, (ip.type.nil?)?"None":ip.type.name,
				(ip.network.nil?)?"None":ip.network.name, ip.is_static_dhcp,
				(ip.dns_devices.nil?)?"None":(ip.dns_devices.collect {|x| x.name}.join ", "),  # filter object names into array - collapse array into string
				ip.ip_str, ip.id ]
		end
		resp_val = { :sEcho => params[:sEcho].to_i, :iTotalRecords => IpAddress.count, :iTotalDisplayRecords => ip_addresses.length,
			 :aaData => aaData } 

    respond_to do |format|
      format.json { render json: resp_val }
    end
	end

  # GET /ip_addresses/1
  # GET /ip_addresses/1.json
  def show
    @ip_address = IpAddress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ip_address }
    end
  end

  # GET /ip_addresses/new
  # GET /ip_addresses/new.json
  def new
    @ip_address = IpAddress.new

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
    @ip_address = IpAddress.new(params[:ip_address])

    respond_to do |format|
      if @ip_address.save
        format.html { redirect_to @ip_address, notice: 'Ip address was successfully created.' }
        format.json { render json: @ip_address, status: :created, location: @ip_address }
      else
        format.html { render action: "new" }
        format.json { render json: @ip_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ip_addresses/1
  # PUT /ip_addresses/1.json
  def update
    @ip_address = IpAddress.find(params[:id])

    respond_to do |format|
      if @ip_address.update_attributes(params[:ip_address])
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
