class Organization < ActiveRecord::Base
  belongs_to :user
  has_many :contributors, dependent: :destroy
  has_many :buckets, dependent: :destroy
  has_many :resources, through: :buckets
  has_many :tweets, through: :resources
  has_many :timesheets, dependent: :destroy
  has_many :activities, dependent: :destroy
  
  def clear_all_tweets
    self.tweets.where(cleared: false).where(sent: true).each do |tweet|
      tweet.cleared = true
      tweet.save!
    end
  end
end
