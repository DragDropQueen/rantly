class Follow < ActiveRecord::Base
  validates_presence_of :followee_id, :follower_id

  belongs_to :user, foreign_key: :follower_id
  belongs_to :user, foreign_key: :followee_id
end
