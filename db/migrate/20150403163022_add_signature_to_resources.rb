class AddSignatureToResources < ActiveRecord::Migration
  def change
    add_column :resources, :signature, :string, default: ""
    add_column :resources, :contributor_id, :integer
  end
end
