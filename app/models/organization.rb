class Organization < ActiveRecord::Base
  has_many :buckets, dependent: :destroy
  has_many :resources, through: :buckets
  has_many :tweets, through: :resources
end
