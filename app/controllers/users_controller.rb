class UsersController < ApplicationController
  layout "signed-out"

  def show
    require_authentication!; set_sidebar

    @comment = Comment.new

    @profile_user = User.find(params[:id])
    respond_to do |format|
      format.html {render layout: 'application'}
      format.json {render json: @profile_user}
    end
  end

  def new
    @direct_post = CloudFileUploader.create_presigned_s3_object
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:show_register_notice] = 'nope'
      flash[:notice] = 'You have registered successfully!'
      redirect_to root_path
    else
      @direct_post = CloudFileUploader.create_presigned_s3_object
      render :new
    end
  end

  def edit
    @direct_post = CloudFileUploader.create_presigned_s3_object

    render layout: 'edit_user' if require_authentication!
  end

  def update
    require_authentication!

    if @user.update(user_params)
      flash[:notice] = 'Your profile has been updated!'
      redirect_to root_path
    else
      flash[:notice] = 'Please fill out all fields!'
      @direct_post = CloudFileUploader.create_presigned_s3_object

      render :edit
    end
  end

  private

  def user_params
    params[:user].permit(:username, :password, :first_name, :last_name, :bio, :frequency, :avatar)
  end
end
