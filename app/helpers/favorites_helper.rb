module FavoritesHelper
  def rant_is_favorited?(rant)
    Favorite.find_by(rant_id: rant.id, user_id: @user.id)
  end
end
