class User < ActiveRecord::Base
  has_secure_password

  validates :username, :last_name, :first_name, :bio, :frequency, presence: true
  validates :username, uniqueness: true

  has_many :rants

end
