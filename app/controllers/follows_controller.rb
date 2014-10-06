class FollowsController < ApplicationController
  before_filter :require_authentication!, :set_sidebar

  def index
    @follows = Follow.where(follower_id: @user.id)
  end

  def create
    Follow.create!({
      follower_id: @user.id,
      followee_id: params[:user_id]
    })
    redirect_to '/dashboard'
  end
end