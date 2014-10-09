class RootController < ApplicationController
  layout 'signed-out'

  def show
    redirect_to dashboard_path if session[:user_id]
  end
end
