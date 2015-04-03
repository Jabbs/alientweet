class AddArticleDateToResources < ActiveRecord::Migration
  def change
    add_column :resources, :article_date, :datetime
  end
end
