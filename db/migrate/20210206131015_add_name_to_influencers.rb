class AddNameToInfluencers < ActiveRecord::Migration[5.2]
  def change

    add_column :influencers, :phone_number, :string
    add_column :influencers, :address, :string
    add_column :influencers, :image_id, :string
    add_column :influencers, :nickname, :string
    add_column :influencers, :details, :text
    add_column :influencers, :password, :string
  end
end
