class AddFollowerCountToInfluencers < ActiveRecord::Migration[5.2]
  def change
    add_column :influencers, :follower_count, :string
  end
end
