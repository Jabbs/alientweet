class AddTagListToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :tag_list, :text, default: ""
  end
end
