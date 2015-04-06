class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.integer :organization_id
      t.date :day_start
      t.date :day_end
      t.integer :tweets_per_day
      t.time :time_slot1
      t.time :time_slot2
      t.time :time_slot3
      t.time :time_slot4

      t.timestamps
    end
  end
end
