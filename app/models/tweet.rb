class Tweet < ActiveRecord::Base
  belongs_to :resource
  belongs_to :contributor
  
  validates :copy, presence: true, length: {minimum: 5, maximum: 118}
end
