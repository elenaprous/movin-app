# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_05_150117) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "address"
    t.string "postal_code"
    t.integer "supermarkets_score"
    t.integer "schools_score"
    t.integer "parks_score"
    t.integer "nightlife_score"
    t.integer "restaurants_score"
    t.integer "transportation_score"
    t.integer "gyms_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "searches", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "location_id", null: false
    t.integer "supermarkets_score"
    t.integer "schools_score"
    t.integer "parks_score"
    t.integer "nightlife_score"
    t.integer "restaurants_score"
    t.integer "transportation_score"
    t.integer "gyms_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ranking"
    t.index ["location_id"], name: "index_searches_on_location_id"
    t.index ["user_id"], name: "index_searches_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "supermarkets_score"
    t.integer "schools_score"
    t.integer "parks_score"
    t.integer "nightlife_score"
    t.integer "restaurants_score"
    t.integer "transportation_score"
    t.integer "gyms_score"
    t.string "important_addresses", default: [], array: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "searches", "locations"
  add_foreign_key "searches", "users"
end
