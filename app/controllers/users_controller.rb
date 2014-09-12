class UsersController < ApplicationController
  layout "signed-out"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'You have registered successfully!'
      redirect_to root_path
    else
      flash[:notice] = 'Please fill out all fields!'
      render :new
    end
  end

  private

  def user_params
    params[:user].permit(:username, :password, :first_name, :last_name, :bio, :frequency)
  end
end
