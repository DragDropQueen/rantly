class Confirmation < ActiveRecord::Base
  belongs_to :user

  def set_confirmed_to_true
    confirmed = true

    user = User.find_by(id: user_id)

    user.active = true

    user.save

    save
  end
end