class AddInfluencerMessageToInfluencerProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :influencer_projects, :influencer_message, :text
  end
end
