module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commented, foreign_key: :commented_id
  end
end