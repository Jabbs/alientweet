class CreateExtractions < ActiveRecord::Migration
  def change
    create_table :extractions do |t|
      t.integer :resource_id, null: false
      t.string :title
      t.text :article
      t.string :author
      t.text :videos, array: true, default: []
      t.text :feeds, array: true, default: []

      t.timestamps
    end
    add_index :extractions, :resource_id
  end
end
