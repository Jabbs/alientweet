class Tweet < ActiveRecord::Base
  belongs_to :resource
  belongs_to :contributor
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :activities, as: :trackable, dependent: :destroy
  
  validates :copy, presence: true, length: {minimum: 5, maximum: 116}
  
  def check_approved_and_add_placement
    if self.approved? && !self.sent?
      tweets = self.resource.bucket.organization.tweets.where(disproved: false).where(approved: true).where(sent: false)
      tweets = tweets - [self]
      placement_ids = tweets.map {|x| x.placement_id}
      if placement_ids.any?
        self.placement_id = placement_ids.sort.last + 1
      else
        self.placement_id = 1
      end
      self.save!
    end
  end
  
  def move_up
    self.placement_id -= 1
    self.save!
  end
  
  def move_down
    self.placement_id += 1
    self.save!
  end
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      all.each do |tweet|
        row = []
        row << tweet.scheduled_to_send_at.strftime("%m/%-d/%y %H:%M")
        row << tweet.copy
        row << tweet.resource.url
        csv << row
      end
    end
  end
end
