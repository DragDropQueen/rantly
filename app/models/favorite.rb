class Favorite < ActiveRecord::Base
  validates_presence_of :user, :rant

  belongs_to :user
  belongs_to :rant
end
