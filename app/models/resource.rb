class Resource < ActiveRecord::Base
  belongs_to :bucket
  has_one :extraction
  has_one :summarization
  has_one :hashtagging
  has_many :tweets, dependent: :destroy
  
  
  def previous
    bucket_id = self.bucket.id
    Resource.where(bucket_id: bucket_id).limit(1).order("id DESC").where("id < ?", id).first
  end

  def next
    Resource.where(bucket_id: bucket_id).limit(1).order("id ASC").where("id > ?", id).first
  end
  
end
