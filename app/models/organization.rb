class Organization < ActiveRecord::Base
  has_many :resources, dependent: :destroy
end
