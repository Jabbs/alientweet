class AddPlacementIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :placement_id, :integer
  end
end
