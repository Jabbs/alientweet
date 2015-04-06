class Tweet < ActiveRecord::Base
  belongs_to :resource
  belongs_to :contributor
  has_many :comments, as: :commentable, dependent: :destroy
  
  validates :copy, presence: true, length: {minimum: 5, maximum: 118}
end
