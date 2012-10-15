class CmtvotesController < ApplicationController
  # GET /cmtvotes
  # GET /cmtvotes.json
  def index
    @cmtvotes = Cmtvote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cmtvotes }
    end
  end

  # GET /cmtvotes/1
  # GET /cmtvotes/1.json
  def show
    @cmtvote = Cmtvote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cmtvote }
    end
  end

  # GET /cmtvotes/new
  # GET /cmtvotes/new.json

  #The new method defined provides the view for the user to vote on a comment. It provides the cmtvotes view with the
  # comment information for the user to vote
  def new
    @cmtvote = Cmtvote.new
    @tempcmt = Comment.find(params[:id])
    @tempost = @tempcmt.post_id
    @@ctemp = @tempcmt.id
    @@ptemp = @tempcmt.post_id
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cmtvote }
    end
  end

  # GET /cmtvotes/1/edit
  def edit
    @cmtvote = Cmtvote.find(params[:id])
  end

  # POST /cmtvotes
  # POST /cmtvotes.json
  # The create method will update the cmtvote table in the db with the user and time of vote. It also updates the
  # 'time' for the post to which the comment belongs to. This ensures that the post is noted as one with recent activity.
  def create

    @cmtvote = Cmtvote.new(params[:id])
    @cmtvote.user_id = session[:user_id]
    @cmtvote.post_id = @@ptemp
    @cmtvote.comment_id = @@ctemp
    @cmtvote.time = Time.now
    @cmt = Comment.find(@@ctemp)
    @cmt.attributes = {:time => Time.now}
    @pst = Post.find(@@ptemp)
    @pst.attributes = {:time => Time.now}
    respond_to do |format|
      if @cmtvote.save
        @pst.save
        @cmt.save
        format.html { redirect_to post_path(@pst), notice: 'Cmtvote was successfully created.' }
        format.json { render json: @cmtvote, status: :created, location: @cmtvote }
      else
        format.html { render action: "new" }
        format.json { render json: @cmtvote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cmtvotes/1
  # PUT /cmtvotes/1.json
  def update
    @cmtvote = Cmtvote.find(params[:id])

    respond_to do |format|
      if @cmtvote.update_attributes(params[:cmtvote])
        format.html { redirect_to @cmtvote, notice: 'Cmtvote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cmtvote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cmtvotes/1
  # DELETE /cmtvotes/1.json
  def destroy
    @cmtvote = Cmtvote.find(params[:id])
    @cmtvote.destroy

    respond_to do |format|
      format.html { redirect_to cmtvotes_url }
      format.json { head :no_content }
    end
  end
end
