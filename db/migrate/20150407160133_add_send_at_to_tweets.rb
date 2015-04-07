class AddSendAtToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :timesheet_send_at, :datetime
  end
end
