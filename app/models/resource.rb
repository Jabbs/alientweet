class Resource < ActiveRecord::Base
  belongs_to :organization
  has_one :extraction
  has_one :summarization
end
