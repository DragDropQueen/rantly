module UsersHelper
  def full_name(person)
    [person.first_name, person.last_name].join(" ")
  end

  def is_followed?(user)
    @follow = Follow.find_by(follower_id: @user.id, followee_id: user.id)
  end
end
