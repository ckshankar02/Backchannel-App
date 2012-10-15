class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json

  # The create method here updates the comment table with a new entry with new comment, post to which the comment belongs to,
  # time of the post, also the user who made the comment. The time is also updated in the Post Table to ensure that the post
  # is noted as one with the recent activity.
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params[:comment])
    @comment.user_id = session[:user_id]
    @comment.post_id = params[:post_id]
    @comment.time = Time.now
    @post.attributes = {:time => Time.now}

    respond_to do |format|
      if @comment.save
        @post.save
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  # The update method here updates the comments table with the changes made to the comment by the user. It also captures
  # the time in the Comment and Post table to make them as components of recent activiy.
  def update
    @comment = Comment.find(params[:id])
    @comment.attributes = {:time => Time.now, :content => params[:comment][:content]}

    @post = Post.find(@comment.post_id)
    @post.attributes = {:time => Time.now}
    respond_to do |format|
      if @comment.save
        @post.save
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  # the destroy method here deletes the comment made by the user.
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.json { head :no_content }
    end
  end
end
