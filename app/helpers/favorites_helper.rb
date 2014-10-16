module FavoritesHelper
  def is_favorited?(rant)
    @favorite = Favorite.find_by(rant_id: rant.id, user_id: @user.id)
  end
end
