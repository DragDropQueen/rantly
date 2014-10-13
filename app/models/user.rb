class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :username, :first_name, :last_name, :bio, :frequency, :password
  validates_uniqueness_of :username, message: 'is taken', on: :create
  validates_length_of :password, minimum: 8, message: '8 char minimum'

  has_many :rants
  has_many :follows, foreign_key: :follower_id
  has_many :follows, foreign_key: :followee_id

  # def empty_fields
  #   if username.blank? || last_name.blank? || first_name.blank? || bio.blank? || frequency.blank?
  #     errors[:base] << "All fields are required"
  #   end
  # end
end

