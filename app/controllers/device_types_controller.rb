# Class which populates the table for the Device Types using either JSON or HTML. 
# Options:
# Show, Edit, Destroy, Create, New and Update options are included. 
# New Device Type button provides an option to add a new device type. 
# Shows ID, Names and when entry was created or updated. 
# Users may choose their preferences of how many entries would be displayed on the page.
# Search option is provided

class DeviceTypesController < ApplicationController
  # GET /device_types
  # GET /device_types.json
  def index
    @device_types = DeviceType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @device_types }
    end
  end

	# POST /dt/dataTable.json
	def dataTable
		s = params[:sSearch]
		if(s.match(/\A[\d]+\z/))
			device_types = DeviceType.where("id LIKE '#{s}%'")
			total = device_types.length
			device_types = device_types[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
		elsif(s.match /.*[\D]+.*/)
			device_types = DeviceType.where("name LIKE '#{s}%'")
			total = device_types.length
			device_types = device_types[params[:iDisplayStart].to_i..(params[:iDisplayStart].to_i+params[:iDisplayLength].to_i)]
		else
			device_types = DeviceType.where(:id => params[:iDisplayStart]..(params[:iDisplayStart]+params[:iDisplayLength]))
			total = DeviceType.count
		end
		aaData = []
		device_types.each do |dt|
			aaData.push [ dt.id, dt.name, dt.created_at,
				dt.updated_at, dt.id ]
		end
		resp_val = { :sEcho => params[:sEcho].to_i, :iTotalRecords => DeviceType.count, :iTotalDisplayRecords => total,
			 :aaData => aaData } 

    respond_to do |format|
      format.json { render json: resp_val }
    end
	end

  # GET /device_types/1
  # GET /device_types/1.json
  def show
    @device_type = DeviceType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @device_type }
    end
  end

  # GET /device_types/new
  # GET /device_types/new.json
  def new
    @device_type = DeviceType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @device_type }
    end
  end

  # GET /device_types/1/edit
  def edit
    @device_type = DeviceType.find(params[:id])
  end

  # POST /device_types
  # POST /device_types.json
  def create
    @device_type = DeviceType.new(params[:device_type])

    respond_to do |format|
      if @device_type.save
        format.html { redirect_to @device_type, notice: 'Device type was successfully created.' }
        format.json { render json: @device_type, status: :created, location: @device_type }
      else
        format.html { render action: "new" }
        format.json { render json: @device_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /device_types/1
  # PUT /device_types/1.json
  def update
    @device_type = DeviceType.find(params[:id])

    respond_to do |format|
      if @device_type.update_attributes(params[:device_type])
        format.html { redirect_to @device_type, notice: 'Device type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @device_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /device_types/1
  # DELETE /device_types/1.json
  def destroy
    @device_type = DeviceType.find(params[:id])
    @device_type.destroy

    respond_to do |format|
      format.html { redirect_to device_types_url }
      format.json { head :no_content }
    end
  end
end
