class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.integer :company_id
      t.integer :influencer_id
      t.string :count
      t.string :is_open
      t.string :price
      t.string :deadline
      t.text :details
      t.string :image_id
      t.timestamps null: false
    end
  end
end
