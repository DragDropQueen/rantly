class SessionsController < ApplicationController
  layout 'signed-out'

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(:username => params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to '/dashboard'
    else
      flash[:notice] = 'Username or password is incorrect'
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
