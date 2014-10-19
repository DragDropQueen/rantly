class Comment < ActiveRecord::Base
  validates_presence_of :body

  belongs_to :user
  belongs_to :commented, polymorphic: true
end
