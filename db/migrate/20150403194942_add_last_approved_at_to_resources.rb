class AddLastApprovedAtToResources < ActiveRecord::Migration
  def change
    add_column :resources, :last_approved_at, :datetime
  end
end
