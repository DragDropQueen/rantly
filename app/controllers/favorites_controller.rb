class FavoritesController < ApplicationController
  before_filter :set_sidebar, :require_authentication!

  def index
  end

  def create
    favorite = Favorite.create!(favorite_params)

    render json: favorite
  end

  def destroy
    favorite = Favorite.find_by(favorite_params)

    favorite.destroy

    render json: favorite
  end

  private

  def favorite_params
    {user_id: @user.id, rant_id: params[:id]}
  end
end
