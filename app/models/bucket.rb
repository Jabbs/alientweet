class Bucket < ActiveRecord::Base
  belongs_to :organization
  has_many :resources, dependent: :destroy
end
