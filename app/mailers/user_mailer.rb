class UserMailer < ActionMailer::Base
  default from: "rant@ly.com"

  def confirmation_email(user, token)
    @user = user
    @url  = root_url + 'confirmations/' + token
    mail(to: @user.email, subject: 'Please confirm your email')
  end
end
