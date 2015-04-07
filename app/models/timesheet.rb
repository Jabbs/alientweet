class Timesheet < ActiveRecord::Base
  belongs_to :organization
  has_many :tweets
  
  validates :organization_id, presence: true
  validates :day_start, presence: true
  validates :day_end, presence: true
  validates :tweets_per_day, presence: true
  
  # after_commit :associate_tweets
  
  
  def associate_tweets
    organization = self.organization
    staged_tweets = organization.tweets.where(disproved: false).where(approved: true).where(sent: false).where(timesheet_id: nil)
    resource_ids = staged_tweets.pluck(:resource_id).uniq
    resources = []
    resource_ids.each do |resource_id|
      resources << organization.resources.find(resource_id)
    end
    
    timesheet_tweets = self.tweets
    
    number_of_days = (self.day_end - self.day_start).to_i + 1
    number_of_tweets_needed = days * self.tweets_per_day
    
    day = self.day_start
    number_of_days.times do |d|
      self.tweets_per_day.times do |n|
        staged_tweets = organization.tweets.where(disproved: false).where(approved: true).where(sent: false).where(timesheet_id: nil)
        timesheet_tweets = self.tweets
        method = "time_slot" + (n+1).to_s
        time = self.send(method)
        datetime = (day.to_s + " " + time.to_s).to_datetime
        staged_tweets.each do |tweet|
          
        end
      end
      day += 1
    end
    
  end
end
