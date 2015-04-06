class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :contributor
  
  validates :contributor_id, presence: true
  validates :commentable_type, presence: true
  validates :commentable_id, presence: true
end
