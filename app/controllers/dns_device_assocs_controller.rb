# A Domain Name Service resolves queries for domain names into IP addresses 
# for the purpose of locating computer services and devices worldwide.
# Reference: http://en.wikipedia.org/wiki/Domain_Name_System
#  
# Class which populates the table for the DNS Device Associations using either JSON or HTML.
# This class includes Options such as Show, Edit, Destroy, New, Create and Update. 

class DnsDeviceAssocsController < ApplicationController

	before_filter :session_update

  # GET /dns_device_assocs
  # GET /dns_device_assocs.json
  def index
    @dns_device_assocs = DnsDeviceAssoc.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dns_device_assocs }
    end
  end

	# GET /dns/autocomplete.json
	def autocomplete
		q = params[:query]
		result = DnsDeviceAssoc.where("name LIKE \"#{q}%\"");
##		resp_val = {:query => q,:suggestions => result.collect {|x| x.name},
#			:data => result.collect {|x| x.id}}	
			resp_val = result.collect{|x| [x.name,x.id]}
    respond_to do |format|
      format.json { render json: resp_val }
    end
	end

	# POST /dns/dataTable.json
	def dataTable
		s = params[:sSearch]
		if s.match(/\d*\./)
			while s.match(/\d*\.\d*\.\d*\.\d*/).nil?
				s += "0."
			end
			s += "0."
			s.chop!
			d = s.gsub(".0",".255")
			s = IP.parse(s)
			d = IP.parse(d)
			dns_assocs = DnsDeviceAssoc.joins(:ip_address).where(:ip_addresses => {:ip_v4 => s.to_i..d.to_i})
			total = dns_assocs.length
			dns_assocs = dns_assocs[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
		elsif s.match(/[0-9a-fA-F]{0,4}:/)
			dns_assocs = DnsDeviceAssoc.joins(:ip_address).where("ip_addresses.ip_v6 LIKE '#{s}%'")
			total = dns_assocs.length
			dns_assocs = dns_assocs[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
		elsif s.match(/./)
			dns_assocs = DnsDeviceAssoc.where("name LIKE '#{s}%'")
			total = dns_assocs.length
			dns_assocs = dns_assocs[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
		else
			dns_assocs = DnsDeviceAssoc.where(:id => params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i))
			total = DnsDeviceAssoc.count
		end
		aaData = []
		dns_assocs.each do |dns|
			aaData.push [ dns.name, (dns.ip_address.nil?)?"None":[dns.ip_id,dns.ip_address.ip_str], dns.created_at, dns.updated_at, dns.id ]
		end
		resp_val = { :sEcho => params[:sEcho].to_i, :iTotalRecords => DnsDeviceAssoc.count, :iTotalDisplayRecords => total,
			 :aaData => aaData } 

    respond_to do |format|
      format.json { render json: resp_val }
    end
	end

  # GET /dns_device_assocs/1
  # GET /dns_device_assocs/1.json
  def show
    @dns_device_assoc = DnsDeviceAssoc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dns_device_assoc }
    end
  end

  # GET /dns_device_assocs/new
  # GET /dns_device_assocs/new.json
  def new
    @dns_device_assoc = DnsDeviceAssoc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dns_device_assoc }
    end
  end

  # GET /dns_device_assocs/1/edit
  def edit
    @dns_device_assoc = DnsDeviceAssoc.find(params[:id])
  end

  # POST /dns_device_assocs
  # POST /dns_device_assocs.json
  def create
    @dns_device_assoc = DnsDeviceAssoc.new(params[:dns_device_assoc])

    respond_to do |format|
      if @dns_device_assoc.save
        format.html { redirect_to @dns_device_assoc, notice: 'Dns device assoc was successfully created.' }
        format.json { render json: @dns_device_assoc, status: :created, location: @dns_device_assoc }
      else
        format.html { render action: "new" }
        format.json { render json: @dns_device_assoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dns_device_assocs/1
  # PUT /dns_device_assocs/1.json
  def update
    @dns_device_assoc = DnsDeviceAssoc.find(params[:id])

    respond_to do |format|
      if @dns_device_assoc.update_attributes(params[:dns_device_assoc])
        format.html { redirect_to @dns_device_assoc, notice: 'Dns device assoc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dns_device_assoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dns_device_assocs/1
  # DELETE /dns_device_assocs/1.json
  def destroy
    @dns_device_assoc = DnsDeviceAssoc.find(params[:id])
    @dns_device_assoc.destroy

    respond_to do |format|
      format.html { redirect_to dns_device_assocs_url }
      format.json { head :no_content }
    end
  end
end
