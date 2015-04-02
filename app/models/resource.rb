class Resource < ActiveRecord::Base
  belongs_to :bucket
  has_one :extraction
  has_one :summarization
  has_one :hashtagging
  has_many :tweets, dependent: :destroy
end
