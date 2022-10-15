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

ActiveRecord::Schema[7.0].define(version: 2022_10_15_042955) do
  create_table "associate_vehicles", force: :cascade do |t|
    t.integer "service_order_id", null: false
    t.integer "vehicle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_order_id"], name: "index_associate_vehicles_on_service_order_id"
    t.index ["vehicle_id"], name: "index_associate_vehicles_on_vehicle_id"
  end

  create_table "deadlines", force: :cascade do |t|
    t.integer "minimum_distance"
    t.integer "maximum_distance"
    t.integer "estimated_time"
    t.integer "mode_of_transport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mode_of_transport_id"], name: "index_deadlines_on_mode_of_transport_id"
  end

  create_table "initiate_service_orders", force: :cascade do |t|
    t.integer "service_order_id", null: false
    t.integer "mode_of_transport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mode_of_transport_id"], name: "index_initiate_service_orders_on_mode_of_transport_id"
    t.index ["service_order_id"], name: "index_initiate_service_orders_on_service_order_id"
  end

  create_table "mode_of_transports", force: :cascade do |t|
    t.string "name"
    t.integer "minimum_distance"
    t.integer "maximum_distance"
    t.integer "minimum_weight"
    t.integer "maximum_weight"
    t.integer "flat_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "price_by_weights", force: :cascade do |t|
    t.integer "minimum_weight"
    t.integer "maximum_weight"
    t.integer "value"
    t.integer "mode_of_transport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mode_of_transport_id"], name: "index_price_by_weights_on_mode_of_transport_id"
  end

  create_table "price_per_distances", force: :cascade do |t|
    t.integer "minimum_distance"
    t.integer "maximum_distance"
    t.integer "rate"
    t.integer "mode_of_transport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mode_of_transport_id"], name: "index_price_per_distances_on_mode_of_transport_id"
  end

  create_table "service_orders", force: :cascade do |t|
    t.string "source_address"
    t.string "product_code"
    t.integer "height"
    t.integer "width"
    t.integer "depth"
    t.integer "weight"
    t.string "destination_address"
    t.string "recipient"
    t.string "recipient_phone"
    t.integer "total_distance"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.integer "price"
    t.integer "deadline"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "nameplate"
    t.string "brand"
    t.string "model"
    t.string "year_of_manufacture"
    t.integer "maximum_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  add_foreign_key "associate_vehicles", "service_orders"
  add_foreign_key "associate_vehicles", "vehicles"
  add_foreign_key "deadlines", "mode_of_transports"
  add_foreign_key "initiate_service_orders", "mode_of_transports"
  add_foreign_key "initiate_service_orders", "service_orders"
  add_foreign_key "price_by_weights", "mode_of_transports"
  add_foreign_key "price_per_distances", "mode_of_transports"
end
