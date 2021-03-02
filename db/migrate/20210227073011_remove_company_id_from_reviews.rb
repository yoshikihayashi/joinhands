class RemoveCompanyIdFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :ompany_id, :integer
  end
end
