class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :trackable, index: true
      t.string :trackable_type
      t.integer :organization_id
      t.string :action

      t.timestamps
    end
  end
end
