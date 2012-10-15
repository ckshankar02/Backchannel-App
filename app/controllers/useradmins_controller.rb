class UseradminsController < ApplicationController
  # GET /useradmins
  # GET /useradmins.json
  def index
    @useradmins = Useradmin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @useradmins }
    end
  end

  # GET /useradmins/1
  # GET /useradmins/1.json
  def show
    @useradmin = Useradmin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @useradmin }
    end
  end

  # GET /useradmins/new
  # GET /useradmins/new.json
  def new
    @useradmin = Useradmin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @useradmin }
    end
  end

  # GET /useradmins/1/edit
  def edit
    @useradmin = Useradmin.find(params[:id])
  end

  # POST /useradmins
  # POST /useradmins.json
  def create
    @useradmin = Useradmin.new(params[:useradmin])

    respond_to do |format|
      if @useradmin.save
        format.html { redirect_to @useradmin, notice: 'Useradmin was successfully created.' }
        format.json { render json: @useradmin, status: :created, location: @useradmin }
      else
        format.html { render action: "new" }
        format.json { render json: @useradmin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /useradmins/1
  # PUT /useradmins/1.json
  def update
    @useradmin = Useradmin.find(params[:id])

    respond_to do |format|
      if @useradmin.update_attributes(params[:useradmin])
        format.html { redirect_to @useradmin, notice: 'Useradmin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @useradmin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /useradmins/1
  # DELETE /useradmins/1.json
  def destroy
    @useradmin = Useradmin.find(params[:id])
    @useradmin.destroy

    respond_to do |format|
      format.html { redirect_to useradmins_url }
      format.json { head :no_content }
    end
  end
end
