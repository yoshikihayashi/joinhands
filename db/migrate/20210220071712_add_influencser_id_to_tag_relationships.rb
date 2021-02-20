class AddInfluencserIdToTagRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :tag_relationships, :influencer_id, :integer
  end
end
