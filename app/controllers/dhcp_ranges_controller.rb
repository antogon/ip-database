class DhcpRangesController < ApplicationController
  # GET /dhcp_ranges
  # GET /dhcp_ranges.json
  def index
    @dhcp_ranges = DhcpRange.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dhcp_ranges }
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
