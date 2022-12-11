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

ActiveRecord::Schema.define(version: 2022_12_11_064627) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "managers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.integer "gender", default: 0
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_managers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.string "serial"
    t.string "name"
    t.string "phone"
    t.string "email"
    t.integer "gender", default: 0
    t.time "arrival_time"
    t.string "state", default: "pending"
    t.datetime "deleted_at"
    t.integer "adult_quantity", default: 1
    t.integer "child_quantity", default: 0
    t.bigint "user_id", null: false
    t.bigint "restaurant_id", null: false
    t.bigint "seat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "arrival_date"
    t.index ["deleted_at"], name: "index_reservations_on_deleted_at"
    t.index ["restaurant_id"], name: "index_reservations_on_restaurant_id"
    t.index ["seat_id"], name: "index_reservations_on_seat_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "title"
    t.string "tel"
    t.string "address"
    t.datetime "deleted_at"
    t.bigint "manager_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "branch", default: ""
    t.time "start_time"
    t.time "end_time"
    t.integer "period_of_reservation", default: 1
    t.index ["deleted_at"], name: "index_restaurants_on_deleted_at"
    t.index ["manager_id"], name: "index_restaurants_on_manager_id"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "kind"
    t.integer "capacity"
    t.integer "deposit", default: 0
    t.string "state", default: "vacancy"
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["restaurant_id"], name: "index_seats_on_restaurant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.integer "gender", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "reservations", "restaurants"
  add_foreign_key "reservations", "seats"
  add_foreign_key "reservations", "users"
  add_foreign_key "restaurants", "managers"
  add_foreign_key "seats", "restaurants"
end
