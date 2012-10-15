class HomepagesController < ApplicationController
  # GET /homepages
  # GET /homepages.json
  def index
    @homepages = Homepage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @homepages }
    end
  end

  # GET /homepages/1
  # GET /homepages/1.json
  def show
    @homepage = Homepage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @homepage }
    end
  end

  # GET /homepages/new
  # GET /homepages/new.json
  def new
    @homepage = Homepage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @homepage }
    end
  end

  # GET /homepages/1/edit
  def edit
    @homepage = Homepage.find(params[:id])
  end

  # POST /homepages
  # POST /homepages.json

  # The create method here handles the loging functionality of the user. It gets the entered username and password from
  # the view and then compares them with the db. In the event of the credentials be validated to true, a session is
  # created for the user.
  def create
    user = User.authenticate params[:username], params[:password]

    #the below code generates the session for valid user.
    if user
      session[:user_name] = user.username
      session[:user_id] = user.id
      useraccess = Useradmin.where(:user_id => user.id)
      useraccess.each do |x|

        # the below condition check sets the current admin role of the user. This information is available in the
        # useradmins table
        if (x.user_id == session[:user_id])
          session[:user_access] = x.adminaccess     #Set the admin role of the user. Y for admin role and N for normal user
        end
      end
      flash[:notice] = "Welcome #{user.username}"

      redirect_to posts_path, :notice => 'You are welcome!'

    else
      flash[:notice] = "Incorrect credentials."                #Error is thrown on invalid credentials.
      redirect_to homepages_path, :notice => 'Invalid Credentials Login Again!'
    end
  end

  # PUT /homepages/1
  # PUT /homepages/1.json
  def update
    @homepage = Homepage.find(params[:id])

    respond_to do |format|
      if @homepage.update_attributes(params[:homepage])
        format.html { redirect_to @homepage, notice: 'Homepage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @homepage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homepages/1
  # DELETE /homepages/1.json
  def destroy
    @homepage = Homepage.find(params[:id])
    @homepage.destroy

    respond_to do |format|
      format.html { redirect_to homepages_url }
      format.json { head :no_content }
    end
  end

  # The 'adminmp' method simply serves as a redirect the adminform where the list of operations that are exclusive to
  # the admin alone are available.
  def adminmp
    respond_to do |format|
      format.html {render :template =>  "/homepages/adminform"}
    end
  end


  #The adminactions method gets the operation selected by the admin in the adminform view. Based on the action selected
  # the Admin the appropriate action is taken and then redirected accordingly.
  def adminactions
    if params[:adminmenu] == "viewuser"
      @userlist = User.all               # Instance variable for providing the list of users to the Admin to view
      respond_to do |format|
        format.html {render :template =>  "/homepages/adminmp"}    # Redirects to the adminmp page
      end
    else if params[:adminmenu] == "category"
          @catlist = Category.all                   #Makes the list of categories avaliable to the actcategory view.
          respond_to do |format|
            format.html {render :template =>  "/homepages/actcategory"}
          end
          else if params[:adminmenu] == "assignrole"
              @useradlist = Useradmin.all          # Makes the list of users avaliable to the assignrole
              respond_to do |format|
                format.html {render :template =>  "/homepages/assignrole"}
              end
              else if params[:adminmenu] == "deluser"
                 @userdellist = User.all          # Makes the list of users avaliable to the assignrole
                 respond_to do |format|
                   format.html {render :template =>  "/homepages/delusers"}
                 end
              end
          end
     end
    end
    if params[:adminmenu] == "reports"
      @rep1 = User.all(:include => [:posts, :postvotes], :group => :id)
      @rep2 = Post.all(:select => 'category, count(category) count', :group => :category)
      @rep3 = Post.all(:include => :postvotes)
      respond_to do |format|
        format.html {render :template => "/homepages/reports"}
      end
    end
  end


  #The addcategory method adds a new category to the Category table. This method is called from actcategory.html.erb view.
  def addcategory
    @cat = Category.new
    @cat.categoryname = params[:addcat]
    @cat.postcount = 0
    @cat.save

    respond_to do |format|
      format.html {
        flash[:notice] = 'Category Added Successfully'
        render :template =>  "/homepages/adminform"
      }
    end
  end


  # The delcategory table deletes the category selected by the user.
  def delcategory

    findcat = Category.find(params[:category][:id])
    findcat.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = 'Category Deleted Successfully'
        render :template =>  "/homepages/adminform"
      }
    end
  end


  # the Assignrole method assigs/revokes the admin role for a user select by the admin.
  def assignrole
    @userad = Useradmin.where(:user_id => params[:id])
    @userad.each do |x|
    if x.adminaccess == "n"
      x.attributes = {:adminaccess => "y"}     # if the admin role is not available to the user, then adminRole is granted to the user
    else
      x.attributes = {:adminaccess => "n"}    # if the user already is granted with a admin role, then it is revoked.
    end
    x.save
    end
    @useradlist = Useradmin.all     #The list of users is make available to the admin again
    respond_to do |format|
      format.html {
        render :template =>  "/homepages/assignrole"
      }
    end
  end

  def delusers
    @userdel = Useradmin.where(:user_id => params[:id])
    @userdel1 = User.where(:id => params[:id])
    @userdelp = Post.where(:user_id => params[:id])
    @userdelc = Comment.where(:user_id => params[:id])
    @userdelpv = Postvote.where(:user_id => params[:id])
    @userdelcv = Cmtvote.where(:user_id => params[:id])

    @userdel.each do |x|
          x.destroy
    end
    @userdel1.each do |x|
      x.destroy
    end
    @userdelp.each do |x|
      x.destroy
    end
    @userdelc.each do |x|
      x.destroy
    end
    @userdelpv.each do |x|
      x.destroy
    end
    @userdelcv.each do |x|
      x.destroy
    end

    @userdellist = User.all

    respond_to do |format|
      format.html {
        flash[:notice] = 'User Deleted Successfully'
        render :template =>  "/homepages/delusers"
      }
    end

  end


  #The logout method ensures that the session is deleted when the user logouts.
  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    session[:user_access] = nil
    redirect_to new_homepage_path, notice: "You are sucessfully logged out"
  end

end
