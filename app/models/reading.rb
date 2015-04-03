class Reading < ActiveRecord::Base
  # associations
  belongs_to :contributor
  belongs_to :readable, polymorphic: true
  
  # validations
  validates :contributor_id, presence: true, uniqueness: { scope: [:readable_id, :readable_type] }
  validates :readable_id, presence: true
  validates :readable_type, presence: true
end
