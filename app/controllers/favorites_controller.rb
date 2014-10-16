class FavoritesController < ApplicationController
  before_filter :set_sidebar, :require_authentication!

  def index

  end

  def create
    Favorite.create!(favorite_params)

    redirect_to :back
  end

  def destroy
    Favorite.destroy(params[:id])

    redirect_to :back
  end

  private

  def favorite_params
    {user_id: @user.id, rant_id: params[:rant_id]}
  end
end
