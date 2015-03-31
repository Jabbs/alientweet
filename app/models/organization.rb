class Organization < ActiveRecord::Base
  has_many :buckets, dependent: :destroy
end
