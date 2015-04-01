class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :resource_id
      t.string :copy
      t.string :link
      t.boolean :approved, default: false
      t.boolean :sent, default: false

      t.timestamps
    end
    add_index :tweets, :resource_id
  end
end
