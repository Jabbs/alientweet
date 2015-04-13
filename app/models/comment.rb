class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :contributor
  has_many :activities, as: :trackable, dependent: :destroy
  
  validates :contributor_id, presence: true
  validates :commentable_type, presence: true
  validates :commentable_id, presence: true
end
