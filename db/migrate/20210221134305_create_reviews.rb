class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer "influencer_id"
      t.integer "company_id"
      t.float "rate", null: false, default: 0
      
      t.timestamps
    end
  end
end
