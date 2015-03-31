class ChangeResourceAssociation < ActiveRecord::Migration
  def up
    remove_column :resources, :organization_id
    add_column :resources, :bucket_id, :integer
    add_index :resources, :bucket_id
  end
  
  def down
    add_column :resources, :organization_id, :integer
    remove_column :resources, :bucket_id
    add_index :resources, :organization_id
  end
end
