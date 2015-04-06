class AddTimeslotIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :timesheet_id, :integer
  end
end
