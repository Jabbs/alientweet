class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :url
      t.text :body
      t.integer :organization_id
      
      t.timestamps
    end
    add_index :resources, :organization_id
  end
end
