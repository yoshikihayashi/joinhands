class AddCompanyCheckedToInfluencerProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :influencer_projects, :company_checked, :boolean
  end
end
