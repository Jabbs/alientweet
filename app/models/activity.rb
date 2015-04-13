class Activity < ActiveRecord::Base
  belongs_to :trackable, polymorphic: true
  belongs_to :organization
  
  # validations
  validates :trackable_type, presence: true
  validates :trackable_id, presence: true
  validates :organization_id, presence: true
end
