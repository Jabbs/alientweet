class Bucket < ActiveRecord::Base
  belongs_to :organization
  has_many :resources, dependent: :destroy
  has_many :tweets, through: :resources
end
