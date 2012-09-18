class DnsDeviceAssocsController < ApplicationController
  # GET /dns_device_assocs
  # GET /dns_device_assocs.json
  def index
    @dns_device_assocs = DnsDeviceAssoc.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dns_device_assocs }
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
