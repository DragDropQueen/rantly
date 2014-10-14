class SessionsController < ApplicationController
  layout 'signed-out'

  def new
    @session = Session.new(params)
  end

  def create
    @session = Session.new(params)

    if @session.authenticate
      set_session
      redirect_to '/dashboard'
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def set_session
    session[:user_id] = @session.user.id
  end
end
