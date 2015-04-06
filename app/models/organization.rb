class Organization < ActiveRecord::Base
  belongs_to :user
  has_many :contributors, dependent: :destroy
  has_many :buckets, dependent: :destroy
  has_many :resources, through: :buckets
  has_many :tweets, through: :resources
end
