class CreateInfluencerProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :influencer_projects do |t|
      t.integer :status
      t.text :message
      t.integer :influencer_id
      t.integer :project_id

      t.timestamps
    end
  end
end
