class CreateAliens < ActiveRecord::Migration
  def change
    create_table :aliens do |t|
      t.string :url
      t.text :body

      t.timestamps null: false
    end
  end
end
