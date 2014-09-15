class Rant < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :rant
end
