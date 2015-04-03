class Contributor < ActiveRecord::Base
  belongs_to :organization
  has_many :resources
end
