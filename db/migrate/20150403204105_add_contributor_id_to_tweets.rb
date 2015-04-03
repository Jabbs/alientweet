class AddContributorIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :contributor_id, :integer
  end
end
