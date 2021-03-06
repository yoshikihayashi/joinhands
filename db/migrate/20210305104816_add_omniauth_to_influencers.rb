class AddOmniauthToInfluencers < ActiveRecord::Migration[5.2]
  def change
    add_column :influencers, :provider, :string
    add_column :influencers, :uid, :string
  end
end
