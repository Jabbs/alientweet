class AddColumnsToResources < ActiveRecord::Migration
  
  def change
    add_column :resources, :read, :boolean, default: false
    add_column :resources, :approved, :boolean, default: false
  end
  
end
