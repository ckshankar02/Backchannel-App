class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json

  #The following action are done by the index method.
  # 1. This ensures that user whose is not logged in is set to guest session.
  # 2. It renders the list of post based on the time. Recent being the first
  def index
    if params[:id] == "guest"
      session[:user_id] = -1
      session[:username] = "guest"
      session[:user_access] = "n"
    end
    @userinfo = Array.new
    @posts = Post.find(:all, :order => "time DESC")
    @posts.each { |x| @userinfo[x.id] = User.find(x.user_id).username}
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  # The Show method captures the following functionalities
  # 1. It provides the information whether a user has voted for post selected.
  # 2. It provides the information whether a user has voted for a comment.
  # 3. Primary function of this show method is to render the selected post content and all the comments made on it.
  # 4. It also provides information to the POST/Show.html with enough information to identify whether the post and its
  #    comments were made by the user in current session.
  def show
    @cuserinfo = Array.new
    @cvote = Array.new
    @callvote = Array.new
    @cvstatus = Array.new
    @post = Post.find(params[:id])
    @t = @post.time
    @sortedcmt = @post.comments.order("time DESC")
    @usercount = 0
    @pcmt = Comment.where(:post_id => @post.id)

    @pcmt.each do |x|
      @cuserinfo[x.id] = User.find(x.user_id).username
    end


    @pvote = Postvote.where(:user_id => session[:user_id]).where(:post_id => @post.id).count
    @pallvote = Postvote.where(:post_id => @post.id).count

    if @pvote > 0
      if @pallvote == 1
      @pvstatus = "You have voted"
      else if @pallvote > 3
          @pvstatus = "You and #{@pvote} other users have voted"
      else
          @pvstatus = "You and 1 other user has voted"
      end
      end
    else
      if @pallvote == 1
      @pvstatus = "One user has voted"
        else if @pallvote == 0
          @pvstatus = "No votes yet !!!"

      else
        @pvstatus = "#{@pallvote} users have voted"
      end
        end
    end

    @pcmt.each do |x|
    @cvote[x.id] = Cmtvote.where(:user_id => session[:user_id]).where(:comment_id => x.id ).count
    @callvote[x.id] = Cmtvote.where(:comment_id => x.id).count

    if @cvote[x.id] > 0
      if @callvote[x.id] == 1
        @cvstatus[x.id] = "You have voted"
      else if @callvote[x.id] > 3
             @cvstatus[x.id] = "You and #{@cvote[x.id]} other users have voted"
           else
             @cvstatus[x.id] = "You and 1 other user has voted"
           end
      end
    else
      if @callvote[x.id] == 1
        @cvstatus[x.id] = "One user has voted"
      else if @callvote[x.id] == 0
             @cvstatus[x.id] = ""

           else
             @cvstatus[x.id] = "#{@callvote[x.id]} users have voted"
           end
      end
    end
    end

      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
end


  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @uid = session[:user_id]
    @catlist = Category.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @catlist = Category.all
  end

  # POST /posts
  # POST /posts.json
  # The below create method updates the post table in the db with a new post entry.
  def create
    @post = Post.new(params[:post])
    @post.user_id = session[:user_id]
    @post.time = Time.now
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json

  # the update method updates the db with the changes made on the post.
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  # The destroy method deletes the selected post
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.json { head :no_content }
    end
  end



  # The contentsearch method allows a user to search contents by user, content and category.
  def contentsearch
       srchtype = params[:type_srch]
       blank_check = 0

       if srchtype == "user"
         searchkey = params[:searchuser]
        if searchkey.blank?
           blank_check = 1
        else
         q = "%#{searchkey}%"
         @postrst = User.all(:conditions => ["username LIKE ?", q], :include => :posts)  # Returns all the posts made by the selected user
         if @postrst.count > 0
          @rststatus = "#{@postrst.count} Matches Found !!"
         else
           @rststatus = "No Matches Found !!"
         end
        end
       end

       if srchtype == "category"
        searchkey = params[:category][:id]
         if searchkey.blank?
          blank_check = 1
         else
          q = "%#{searchkey}%"
          @postrst = User.all(:conditions => ["posts.category like ?", q], :include => :posts)         # Returns all the posts that belongs to the selected category
          if @postrst.count > 0
            @rststatus = "Matches found in #{searchkey} Category "
          else
            @rststatus = "No posts under the category "
          end
         end
       end

       if srchtype == "content"
         searchkey = params[:searchcont]
         if searchkey.blank?
          blank_check = 1
         else
          q = "%#{searchkey}%"
          @postrst = User.all(:conditions => ["posts.content like ?", q], :include => :posts)     #Returns all the posts matching the content.
          if @postrst.count > 0
           @rststatus = "#{@postrst.count} Matches Found "
          else
           @rststatus = "No Match Found "
          end
         end
       end

       if blank_check == 1
         @catlist = Category.all
         respond_to do |format|
         format.html {
           flash[:notice] = 'Enter Search Content'
           render :template =>  "/posts/srchform"
         }
         end
       else
         respond_to do |format|
           format.html {render :template =>  "/posts/search"}
         end
      end
  end

  # The searchcont method simply acts as a redirect to the srchform. It provides the view a instance variable
  # listing all the categories in the Category table
  def searchcont
    @catlist = Category.all
    respond_to do |format|
      format.html {render :template =>  "/posts/srchform"}
    end
  end

  def postvoter
    @selpost = Post.find(params[:id])
    q = "#{params[:id]}"
    @pstvoter = User.all(:conditions => ["postvotes.post_id = ?", q], :include => :postvotes)
    respond_to do |format|
      format.html {render :template =>  "/posts/postvoter"}
    end
  end
end
