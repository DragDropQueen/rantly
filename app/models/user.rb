class User < ActiveRecord::Base
  include Searchable, Commentable, Confirmable
  has_secure_password

  validates_presence_of :email, :first_name, :last_name, :bio, :frequency
  validates_presence_of :password, on: :create
  validates_uniqueness_of :email, message: 'is taken', on: :create
  validates_length_of :password, minimum: 8, message: '8 char minimum', on: :create

  has_many :rants
  has_many :followers, class_name: 'Follow', foreign_key: :follower_id
  has_many :followees, class_name: 'Follow', foreign_key: :followee_id
  has_many :favorited_rants, through: :favorites, source: :rant
  has_many :favorites
  has_one :confirmation
end

