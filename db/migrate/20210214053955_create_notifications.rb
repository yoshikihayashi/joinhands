class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications,:visitor_id,:integer
    remove_column :notifications,:visited_id,:integer
    remove_column :notifications,:influencer_id,:integer
    remove_column :notifications,:company_id,:integer
    remove_column :notifications,:influencer_id,:integer
   
    add_column :notifications,:visitedinflencer_id,:integer
    add_column :notifications,:visitorinfluencer_id,:integer
    add_column :notifications,:visitedcompany_id,:integer
    add_column :notifications,:visitorcompany_id,:integer
    add_column :notifications,:influencer_project_id,:integer
    

    add_index :notifications, :visitorinfluencer_id
    add_index :notifications, :visitedinflencer_id
    add_index :notifications, :visitorcompany_id
    add_index :notifications, :visitedcompany_id
    add_index :notifications, :influencer_project_id
  end
end
