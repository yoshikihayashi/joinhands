class RenameCompanyIdColumnToReviews < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :company_id, :project_id
  end
end
