# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_20_071712) do

  create_table "companies", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "company_name"
    t.string "representative_name"
    t.string "phone_number"
    t.text "business_detail"
    t.string "employee_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_companies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "influencer_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "influencer_projects", force: :cascade do |t|
    t.integer "status"
    t.text "message"
    t.integer "influencer_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "checked"
    t.boolean "company_checked"
  end

  create_table "influencers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "name_kana"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.string "address"
    t.string "image_id"
    t.string "nickname"
    t.text "details"
    t.string "password"
    t.index ["email"], name: "index_influencers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_influencers_on_reset_password_token", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "project_id"
    t.string "action", default: "", null: false
    t.boolean "read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visitedinflencer_id"
    t.integer "visitorinfluencer_id"
    t.integer "visitedcompany_id"
    t.integer "visitorcompany_id"
    t.integer "influencer_project_id"
    t.index ["influencer_project_id"], name: "index_notifications_on_influencer_project_id"
    t.index ["project_id"], name: "index_notifications_on_project_id"
    t.index ["visitedcompany_id"], name: "index_notifications_on_visitedcompany_id"
    t.index ["visitedinflencer_id"], name: "index_notifications_on_visitedinflencer_id"
    t.index ["visitorcompany_id"], name: "index_notifications_on_visitorcompany_id"
    t.index ["visitorinfluencer_id"], name: "index_notifications_on_visitorinfluencer_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "company_id"
    t.integer "influencer_id"
    t.string "count"
    t.string "is_open"
    t.string "price"
    t.string "deadline"
    t.text "details"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "tag_relationships", force: :cascade do |t|
    t.integer "project_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "influencer_id"
    t.index ["project_id", "tag_id"], name: "index_tag_relationships_on_project_id_and_tag_id", unique: true
    t.index ["project_id"], name: "index_tag_relationships_on_project_id"
    t.index ["tag_id"], name: "index_tag_relationships_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
