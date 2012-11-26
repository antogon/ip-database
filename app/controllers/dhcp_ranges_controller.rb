# A DHCP scope is a valid range of IP addresses which are available for assignments or lease to client computers on a particular subnet. 
# In a DHCP server, range must be configured to determine the address pool of IPs which the server can provide to DHCP clients.
# Ranges determine which IP addresses are provided to the clients. Ranges should be defined and activated before DHCP clients use the DHCP server for its dynamic IP configuration. 
# As many ranges on a DHCP server as is required could be configured in network environment.
# Reference: http://wiki.answers.com/Q/What_is_scope_and_super_scope
 
# This Class populates the table for the DHCP Ranges using either JSON or HTML format.
# This Class includes Options such as Show, Edit, Destroy, New, Create and Update

class DhcpRangesController < ApplicationController

	before_filter :session_update

  # GET /dhcp_ranges
  # GET /dhcp_ranges.json
  def index
    @dhcp_ranges = DhcpRange.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dhcp_ranges }
    end
  end

	# POST /dhcp/dataTable.json
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
			dhcp_ranges = DhcpRange.where("((start_ip > '#{s.to_hex}' AND start_ip < '#{d.to_hex}') OR (end_ip > '#{s.to_hex}' AND end_ip < '#{d.to_hex}')) AND ip_v4 = 1")
			total = dhcp_ranges.length
			dhcp_ranges = dhcp_ranges[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
		elsif(s.match /[0-9a-fA-F]{0,4}:/)
			while s.match(/([0-9a-fA-F]{0,4}:){7}/).nil?
				s += "0000:"
			end
			s += "0000:"
			s.chop!
			d = s.gsub(":0000",":FFFF")
			s = IP.parse(s)
			d = IP.parse(d)
			dhcp_ranges = DhcpRange.where("((start_ip > '#{s.to_hex}' AND start_ip < '#{d.to_hex}') OR (end_ip > '#{s.to_hex}' AND end_ip < '#{d.to_hex}')) AND ip_v4 = 0")
			total = dhcp_ranges.length
			dhcp_ranges = dhcp_ranges[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
		elsif s.match(/.*/)
			dhcp_ranges = DhcpRange.joins(:network).where("networks.name LIKE \"#{s}%\"")
			total = dhcp_ranges.length
			dhcp_ranges = dhcp_ranges[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
		else
			dhcp_ranges = DhcpRange.where(:id => params[:iDisplayStart]..(params[:iDisplayStart]+params[:iDisplayLength]))
			total = DhcpRange.count
		end
		aaData = []
		dhcp_ranges.each do |dhcp|
			aaData.push [ dhcp.start_ip, dhcp.end_ip, dhcp.network.nil? ? "None" : [dhcp.network.id,dhcp.network.name], dhcp.id ]
		end
		resp_val = { :sEcho => params[:sEcho].to_i, :iTotalRecords => DhcpRange.count, :iTotalDisplayRecords => total,
			 :aaData => aaData } 

    respond_to do |format|
      format.json { render json: resp_val }
    end
	end

  # GET /dhcp_ranges/1
  # GET /dhcp_ranges/1.json
  def show
    @dhcp_range = DhcpRange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dhcp_range }
    end
  end

  # GET /dhcp_ranges/new
  # GET /dhcp_ranges/new.json
  def new
    @dhcp_range = DhcpRange.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dhcp_range }
    end
  end

  # GET /dhcp_ranges/1/edit
  def edit
    @dhcp_range = DhcpRange.find(params[:id])
  end

  # POST /dhcp_ranges
  # POST /dhcp_ranges.json
  def create
    @dhcp_range = DhcpRange.new(params[:dhcp_range])

    respond_to do |format|
      if @dhcp_range.save
        format.html { redirect_to @dhcp_range, notice: 'Dhcp range was successfully created.' }
        format.json { render json: @dhcp_range, status: :created, location: @dhcp_range }
      else
        format.html { render action: "new" }
        format.json { render json: @dhcp_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dhcp_ranges/1
  # PUT /dhcp_ranges/1.json
  def update
    @dhcp_range = DhcpRange.find(params[:id])

    respond_to do |format|
      if @dhcp_range.update_attributes(params[:dhcp_range])
        format.html { redirect_to @dhcp_range, notice: 'Dhcp range was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dhcp_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dhcp_ranges/1
  # DELETE /dhcp_ranges/1.json
  def destroy
    @dhcp_range = DhcpRange.find(params[:id])
    @dhcp_range.destroy

    respond_to do |format|
      format.html { redirect_to dhcp_ranges_url }
      format.json { head :no_content }
    end
  end
end
