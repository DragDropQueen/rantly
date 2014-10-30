module UsersHelper
  def full_name(person)
    [person.first_name, person.last_name].join(" ")
  end

  def is_followed?(user)
    @follow = Follow.find_by(follower_id: @user.id, followee_id: user.id)
  end

  def direct_post
    @direct_post ||= CloudFileUploader.create_presigned_s3_object
  end
end
