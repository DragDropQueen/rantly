class Rant < ActiveRecord::Base
  include Searchable, Commentable

  validates_presence_of :title, :rant
  validates_length_of :title, maximum: 50
  validates_length_of :rant, minimum: 140

  belongs_to :user
  has_many :favorites
end
