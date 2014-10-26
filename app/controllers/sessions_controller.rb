class SessionsController < ApplicationController
  layout 'signed-out'

  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)


    if @session.valid?
      set_session
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def set_session
    session[:user_id] = @session.user_id
  end
end
