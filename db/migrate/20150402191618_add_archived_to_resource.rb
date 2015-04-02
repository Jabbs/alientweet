class AddArchivedToResource < ActiveRecord::Migration
  def change
    add_column :resources, :archived, :boolean, default: false
    add_column :resources, :last_archived_at, :datetime
  end
end
