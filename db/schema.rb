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

ActiveRecord::Schema.define(version: 2019_11_04_031756) do

  create_table "battery_shifts", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean "complete", default: false
    t.integer "employee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_battery_shifts_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vehicle_assignments", force: :cascade do |t|
    t.integer "battery_shift_id"
    t.integer "vehicle_id"
    t.datetime "completed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["battery_shift_id"], name: "index_vehicle_assignments_on_battery_shift_id"
    t.index ["vehicle_id"], name: "index_vehicle_assignments_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_plate"
    t.float "battery_level"
    t.boolean "in_use"
    t.string "model"
    t.float "location_lat"
    t.float "location_long"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "last_parked_address"
  end

  add_foreign_key "battery_shifts", "employees"
  add_foreign_key "vehicle_assignments", "battery_shifts"
  add_foreign_key "vehicle_assignments", "vehicles"
end
