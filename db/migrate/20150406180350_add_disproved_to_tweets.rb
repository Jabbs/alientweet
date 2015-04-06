class AddDisprovedToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :disproved, :boolean, default: false
    add_column :tweets, :last_disproved_at, :datetime
  end
end
