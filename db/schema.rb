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

ActiveRecord::Schema[7.2].define(version: 2024_09_06_184806) do
  create_table "production_plans", charset: "utf8mb3", force: :cascade do |t|
    t.integer "production_count", null: false
    t.integer "actual", null: false
    t.float "operation_rate", null: false
    t.datetime "start_time", precision: nil, null: false
    t.datetime "end_time", precision: nil
    t.bigint "shift_id", null: false
    t.bigint "change_shift_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "registration_id"
    t.index ["change_shift_id"], name: "index_production_plans_on_change_shift_id"
    t.index ["shift_id"], name: "index_production_plans_on_shift_id"
  end

  create_table "registrations", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.integer "ct"
    t.float "yield"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shifts", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "production_plans", "shifts"
  add_foreign_key "production_plans", "shifts", column: "change_shift_id"
end
