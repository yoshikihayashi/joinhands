class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitorinfluencer_id
      t.integer :visitedinflencer_id
      t.integer :visitorcompany_id
      t.integer :visitedcompany_id
      t.integer :project_id
      t.integer :influencer_project_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end

    add_index :notifications, :visitorinfluencer_id
    add_index :notifications, :visitedinflencer_id
    add_index :notifications, :visitorcompany_id
    add_index :notifications, :visitedcompany_id
    add_index :notifications, :project_id
    add_index :notifications, :influencer_project_id
  end
end
