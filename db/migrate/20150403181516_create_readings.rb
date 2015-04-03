class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.string :readable_type
      t.integer :readable_id
      t.integer :contributor_id

      t.timestamps
    end
    add_index :readings, :contributor_id
    add_index :readings, [:readable_type, :readable_id]
  end
end
