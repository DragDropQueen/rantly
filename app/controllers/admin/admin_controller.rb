class Admin::AdminController < ApplicationController
  layout 'admin'
  before_filter :require_admin_authentication!

  def require_admin_authentication!
    @user = User.find(session[:user_id])

    if @user && @user.admin
      true
    else
      redirect_to root_path, notice: "Oops, you don't have permission to do that!"
      false
    end
  end
end