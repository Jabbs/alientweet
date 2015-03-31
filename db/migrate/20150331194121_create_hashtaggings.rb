class CreateHashtaggings < ActiveRecord::Migration
  def change
    create_table :hashtaggings do |t|
      t.integer :resource_id
      t.text :text
      t.text :hashtags, array: true, default: []

      t.timestamps
    end
    add_index :hashtaggings, :resource_id
  end
end
