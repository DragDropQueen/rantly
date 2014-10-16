class RootController < ApplicationController
  layout 'signed-out'

  def show
    if session[:user_id]
      redirect_to dashboard_path
    else
      render :show
    end

    session[:show_register_notice] ||= 'show'
  end
end
