class Contributor < ActiveRecord::Base
  belongs_to :organization
  has_many :resources
  has_many :readings, as: :readable, dependent: :destroy
  has_many :tweets
end
