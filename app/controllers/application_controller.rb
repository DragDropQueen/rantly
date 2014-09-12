class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def require_authentication!
    @user = User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: "You must be logged in to do that!"
  end
end
