class AddClearedToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :cleared, :boolean, default: false
  end
end
