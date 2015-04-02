class AddLastApprovedAtToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :last_approved_at, :datetime
    add_column :tweets, :last_sent_at, :datetime
  end
end
