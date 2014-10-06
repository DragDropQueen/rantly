module UsersHelper

  def full_name(person)
    [person.first_name, person.last_name].join(" ")
  end

  def check_if_follow(user)
    @follow = Follow.find_by(follower_id: @user.id, followee_id: user.id)
    @follow == nil ? false : true
  end
end
