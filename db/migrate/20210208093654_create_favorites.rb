class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :influencer_id
      t.integer :project_id
      t.timestamps
    end
  end
end
