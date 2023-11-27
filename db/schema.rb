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

ActiveRecord::Schema[7.1].define(version: 2023_11_27_155940) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "address"
    t.string "postal_code"
    t.integer "supermarkets_info"
    t.integer "schools_info"
    t.integer "parks_info"
    t.integer "nightlife_info"
    t.integer "restaurants_info"
    t.integer "transportation_info"
    t.integer "gym_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "searches", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "location_id", null: false
    t.integer "supermarket_score"
    t.integer "schools_score"
    t.integer "parks_score"
    t.integer "nightlife_score"
    t.integer "restaurants_score"
    t.integer "transportation_score"
    t.integer "gyms_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "important_address"
    t.integer "supermarkets_i"
    t.integer "schools_i"
    t.integer "parks_i"
    t.integer "nightlife_i"
    t.integer "restaurants_i"
    t.integer "transportation_i"
    t.integer "gyms_i"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "searches", "locations"
  add_foreign_key "searches", "users"
end
