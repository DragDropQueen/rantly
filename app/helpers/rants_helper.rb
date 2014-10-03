module RantsHelper
  def get_latest_rants
    Rant.where("user_id != #{@user.id}").reverse[0..1]
  end
end
