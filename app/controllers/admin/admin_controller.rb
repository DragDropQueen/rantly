class Admin::AdminController < ApplicationController
  layout 'admin'
  before_filter :require_admin_authentication!

  def reset
    session[:user_id] = session[:admin_id]

    redirect_to admin_dashboard_path
  end

  def impersonate
    session[:user_id] = params[:id]

    redirect_to dashboard_path
  end

  def require_admin_authentication!
    @user = User.find_by(id:session[:admin_id])

    if @user && @user.admin
      true
    else
      redirect_to root_path, notice: "Oops, you don't have permission to do that!"
      false
    end
  end
end