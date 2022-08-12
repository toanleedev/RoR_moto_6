# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_07_27_152016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "province"
    t.string "district"
    t.string "ward"
    t.string "street"
    t.text "geocoding", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "count_rental_days"
    t.decimal "amount", precision: 18
    t.string "message"
    t.integer "status", default: 0
    t.string "confirmation_token"
    t.boolean "is_confirmed", default: false
    t.boolean "is_home_delivery", default: false
    t.string "delivery_address"
    t.boolean "is_prepaid", default: false
    t.decimal "prepaid_discount", precision: 18
    t.string "payment", default: "cash", null: false
    t.string "payment_info"
    t.boolean "is_paid", default: false
    t.decimal "discount", precision: 18
    t.bigint "vehicle_id", null: false
    t.bigint "renter_id"
    t.bigint "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_orders_on_owner_id"
    t.index ["renter_id"], name: "index_orders_on_renter_id"
    t.index ["vehicle_id"], name: "index_orders_on_vehicle_id"
  end

  create_table "papers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "card_number"
    t.text "card_front_url"
    t.text "card_back_url"
    t.string "driver_number"
    t.text "driver_front_url"
    t.datetime "verified_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_card_verified"
    t.datetime "card_verified_at"
    t.boolean "is_driver_verified"
    t.datetime "driver_verified_at"
    t.text "other_license_url"
    t.index ["user_id"], name: "index_papers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.text "photo_url"
    t.datetime "birth"
    t.string "phone"
    t.integer "gender"
    t.boolean "is_partner", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "provider"
    t.string "uid"
    t.boolean "is_admin"
    t.bigint "address_default_id"
    t.index ["address_default_id"], name: "index_users_on_address_default_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "vehicle_images", force: :cascade do |t|
    t.bigint "vehicle_id", null: false
    t.text "image_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vehicle_id"], name: "index_vehicle_images_on_vehicle_id"
  end

  create_table "vehicle_options", force: :cascade do |t|
    t.string "key"
    t.string "name_vi"
    t.string "name_en"
  end

  create_table "vehicles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "description"
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "brand_id"
    t.bigint "type_id"
    t.bigint "engine_id"
    t.datetime "year_produce"
    t.string "name"
    t.index ["brand_id"], name: "index_vehicles_on_brand_id"
    t.index ["engine_id"], name: "index_vehicles_on_engine_id"
    t.index ["type_id"], name: "index_vehicles_on_type_id"
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "orders", "users", column: "owner_id"
  add_foreign_key "orders", "users", column: "renter_id"
  add_foreign_key "orders", "vehicles"
  add_foreign_key "papers", "users"
  add_foreign_key "users", "addresses", column: "address_default_id"
  add_foreign_key "vehicle_images", "vehicles"
  add_foreign_key "vehicles", "users"
  add_foreign_key "vehicles", "vehicle_options", column: "brand_id"
  add_foreign_key "vehicles", "vehicle_options", column: "engine_id"
  add_foreign_key "vehicles", "vehicle_options", column: "type_id"
end
