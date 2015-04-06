class Timesheet < ActiveRecord::Base
  belongs_to :organization
  has_many :tweets
  
  validates :organization_id, presence: true
  validates :day_start, presence: true
  validates :day_end, presence: true
  validates :tweets_per_day, presence: true
end
