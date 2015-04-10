class AddScheduledToSendAtToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :scheduled_to_send_at, :datetime
  end
end
