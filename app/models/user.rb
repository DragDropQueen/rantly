class User < ActiveRecord::Base
  has_secure_password

  validates :username, :last_name, :first_name, :bio, :frequency, presence: true
  validates :username, uniqueness: true

  has_many :rants
  has_many :follows, foreign_key: :follower_id
  has_many :follows, foreign_key: :followee_id
end
