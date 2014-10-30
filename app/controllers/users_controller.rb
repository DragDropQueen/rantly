class UsersController < ApplicationController
  layout "signed-out"

  def show
    require_authentication!; set_sidebar

    @profile_user = User.find(params[:id])

    respond_to do |format|
      format.html {render layout: 'application'}
      format.json {render json: @profile_user}
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      publish_keen_stats
      hide_register_notice
      @user.create_confirmation_and_send_email
      redirect_to root_path, notice: 'You have registered successfully! Please check your email for the next steps'
    else
      render :new
    end
  end

  def edit
    render layout: 'edit_user' if require_authentication!
  end

  def update
    require_authentication!

    if @user.update(user_params)
      redirect_to root_path, notice: 'Your profile has been updated!'
    else
      flash[:notice] = 'Please fill out all fields!'
      render :edit
    end
  end

  private

  def user_params
    params[:user].permit(:email, :password, :first_name, :last_name, :bio, :frequency, :avatar)
  end

  def publish_keen_stats
    Keen.publish(:user, {:email => @user.email}) if Rails.env == 'production'
  end

  def hide_register_notice
    session[:show_register_notice] = 'nope'
  end
end
