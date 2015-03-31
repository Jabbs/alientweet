class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string :name
      t.integer :organization_id

      t.timestamps
    end
    add_index :buckets, :organization_id
  end
end
