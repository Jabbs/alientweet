class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
      t.integer :organization_id
      t.string :name

      t.timestamps
    end
    add_index :contributors, :organization_id
  end
end
