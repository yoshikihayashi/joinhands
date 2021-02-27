class CreateCompanyReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :company_reviews do |t|
      t.integer :company_id
      t.float :rate, null: false, default: 0
      t.text :comment

      t.timestamps
    end
  end
end
