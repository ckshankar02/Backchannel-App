class PostvotesController < ApplicationController
  # GET /postvotes
  # GET /postvotes.json


  def index
    @postvotes = Postvote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @postvotes }
    end
  end

  # GET /postvotes/1
  # GET /postvotes/1.json
  def show
    @postvote = Postvote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @postvote }
    end
  end

  # GET /postvotes/new
  # GET /postvotes/new.json
  # Provides the template for voting for a post.
  def new
    @postvote = Postvote.new
    @tempost = Post.find(params[:id])
    @@temp = @tempost.id
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @postvote }
    end
  end

  # GET /postvotes/1/edit
  def edit
    @postvote = Postvote.find(params[:id])
  end

  # POST /postvotes
  # POST /postvotes.json
  # The create method updates the postvote table with the vote made by the user in session on a selected post.
  def create
    @postvote = Postvote.new(params[:id])
    @postvote.user_id = session[:user_id]
    @postvote.post_id = @@temp
    @postvote.time = Time.now
    @pst = Post.find(@postvote.post_id)
    @pst.attributes = {:time => Time.now}        #Updates the time for the vote in the POST table as well. To record recent activity.
    respond_to do |format|
      if @postvote.save
         @pst.save
        format.html { redirect_to post_path(@pst), notice: 'You have voted for the current post' }
        format.json { render json: @postvote, status: :created, location: @postvote }
      else
        format.html { render action: "new", notice: 'Vote not recorded' }
        format.json { render json: @postvote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /postvotes/1
  # PUT /postvotes/1.json
  def update
    @postvote = Postvote.find(params[:id])

    respond_to do |format|
      if @postvote.update_attributes(params[:postvote])
        format.html { redirect_to @postvote, notice: 'Postvote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @postvote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postvotes/1
  # DELETE /postvotes/1.json
  def destroy
    @postvote = Postvote.find(params[:id])
    @postvote.destroy

    respond_to do |format|
      format.html { redirect_to postvotes_url }
      format.json { head :no_content }
    end
  end
end
