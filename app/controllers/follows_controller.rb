class FollowsController < ApplicationController
  before_filter :require_authentication!, :set_sidebar

  def index
    @follows = Follow.where(follower_id: @user.id)
  end

  def create
    follow = Follow.create!({
      follower_id: @user.id,
      followee_id: params[:id]
    })

    render json: follow
  end

  def destroy
    follow = Follow.find_by(followee_id: params[:id], follower_id: @user.id)

    follow.destroy

    render json: follow
  end
end