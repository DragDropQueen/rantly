class RantMailer
  def self.send_mail_to_followers(rant, user)
    Follow.where(followee_id: user.id).each {|follow|
      user = User.find(follow.follower_id)

      UserMailer.follow_email(user, rant).deliver
    }
  end
end