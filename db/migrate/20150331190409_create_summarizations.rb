class CreateSummarizations < ActiveRecord::Migration
  def change
    create_table :summarizations do |t|
      t.integer :resource_id, null: false
      t.text :text
      t.text :sentences, array: true, default: []

      t.timestamps
    end
    add_index :summarizations, :resource_id
  end
end
