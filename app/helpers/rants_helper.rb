module RantsHelper
  def get_latest_rants
    Rant.where("user_id != #{@user.id}").reverse[0..1]
  end

  def get_user_favorited_rants(user)
    Rant.where(user_id: user.id).sort_by {|rant|
      rant.favorites.count
    }.reverse
  end
end
