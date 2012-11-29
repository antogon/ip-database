# Class which populates the table for the Networks using either JSON or HTML format.
# This class includes Options such as Show, New, Edit, Create, Destroy and Update

class NetworksController < ApplicationController

	before_filter :session_update

  # GET /networks
  # GET /networks.json
  def index
    @networks = Network.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @networks }
    end
  end

	# POST /net/dataTable.json
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
			networks = Network.where("(network_no > '#{s.to_hex}' AND network_no < '#{d.to_hex}') OR (netmask > '#{s.to_hex}' AND netmask < '#{d.to_hex}')")
			total = networks.length
			networks = networks[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
		elsif(s.match /[0-9a-fA-F]{0,4}:/)
			while s.match(/([0-9a-fA-F]{0,4}:){7}/).nil?
				s += "0000:"
			end
			s += "0000:"
			s.chop!
			d = s.gsub(":0000",":FFFF")
			s = IP.parse(s)
			d = IP.parse(d)
			networks = Network.where("(network_no > '#{s.to_hex}' AND network_no < '#{d.to_hex}') OR (netmask > '#{s.to_hex}' AND netmask < '#{d.to_hex}')")
			total = networks.length
			networks = networks[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
		elsif s.match /.*\D+.*/
			networks = Network.where("name LIKE '#{s}%' OR router_name LIKE '#{s}%'")
			total = networks.length
			networks = networks[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
		else
			networks = Network.where(:id => params[:iDisplayStart]..(params[:iDisplayStart]+params[:iDisplayLength]))
			total = Network.count
		end
		aaData = []
		networks.each do |net|
			aaData.push [ net.id, net.network_no, net.netmask,
				net.name, net.router_name,
				net.is_vrf,net.is_hsrp,(net.parent.nil?)?"None":[net.parent.id,net.parent.name],
				net.id]
		end
		resp_val = { :sEcho => params[:sEcho].to_i, :iTotalRecords => Network.count, :iTotalDisplayRecords => total,
			 :aaData => aaData } 

    respond_to do |format|
      format.json { render json: resp_val }
    end
	end

  def net_parents
    respond_to do |format|
      format.json { render json: Network.net_in_range?(params[:ip],params[:subnet], :create).collect{|x| {:id => x.id, :name => x.name}} }
    end
  end

  # GET /networks/1
  # GET /networks/1.json
  def show
    @network = Network.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @network }
    end
  end

  # GET /networks/new
  # GET /networks/new.json
  def new
    @network = Network.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @network }
    end
  end

  # GET /networks/1/edit
  def edit
    @network = Network.find(params[:id])
  end

  # POST /networks
  # POST /networks.json
  def create
    @network = Network.new(params[:network])

    respond_to do |format|
      if @network.save
        format.html { redirect_to @network, notice: 'Network was successfully created.' }
        format.json { render json: @network, status: :created, location: @network }
      else
        format.html { render action: "new" }
        format.json { render json: @network.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /networks/1
  # PUT /networks/1.json
  def update
    @network = Network.find(params[:id])

    respond_to do |format|
      if @network.update_attributes(params[:network])
        format.html { redirect_to @network, notice: 'Network was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @network.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /networks/1
  # DELETE /networks/1.json
  def destroy
    @network = Network.find(params[:id])
    @network.destroy

    respond_to do |format|
      format.html { redirect_to networks_url }
      format.json { head :no_content }
    end
  end
end
