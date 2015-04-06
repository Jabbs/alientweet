class Resource < ActiveRecord::Base
  belongs_to :bucket
  belongs_to :contributor
  has_one :extraction
  has_one :summarization
  has_one :hashtagging
  has_many :tweets, dependent: :destroy
  has_many :readings, as: :readable, dependent: :destroy
  has_many :readers, through: :readings, source: :contributor
  has_many :comments, as: :commentable, dependent: :destroy
  
  validates :url, presence: true, uniqueness: {scope: :bucket}
  
  def previous
    bucket_id = self.bucket.id
    Resource.where(bucket_id: bucket_id).limit(1).order("id DESC").where("id < ?", id).first
  end

  def next
    Resource.where(bucket_id: bucket_id).limit(1).order("id ASC").where("id > ?", id).first
  end
  
  def has_been_read
    self.read = true
    self.save!
  end
  
  def check_if_still_read
    if self.readings.size == 0
      self.read = false
      self.save!
    end
  end
  
end
