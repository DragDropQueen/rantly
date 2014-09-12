class RootController < ApplicationController
  layout 'signed-out'

  def show
    redirect_to '/dashboard' if session[:user_id]
  end
end
