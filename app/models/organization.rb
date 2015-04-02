class Organization < ActiveRecord::Base
  has_many :buckets, dependent: :destroy
  has_many :resources, through: :buckets
end
