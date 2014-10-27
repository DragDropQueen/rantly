class UserMailer < ActionMailer::Base
  default from: "rant@ly.com"

  def confirmation_email(user, token)
    @user = user
    @url  = root_url + 'confirmations/' + token
    mail(to: @user.email, subject: 'Please confirm your email')
  end

  def follow_email(user, rant)
    @user = user
    @url = root_url + "rants/#{rant.id}"
    @followee = rant.user

    mail(to: @user.email, subject: "#{@followee.email} has posted a new rant!")
  end
end
