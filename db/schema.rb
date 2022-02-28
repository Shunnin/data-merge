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

ActiveRecord::Schema.define(version: 2022_02_28_031032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hotels", force: :cascade do |t|
    t.string "hotel_id", null: false
    t.string "destination_id", null: false
    t.text "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotel_id", "destination_id"], name: "index_hotels_on_hotel_id_and_destination_id", unique: true
  end

  create_table "procuring_tasks", force: :cascade do |t|
    t.string "source_ref", null: false
    t.string "source_type", null: false
    t.integer "state", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["source_type", "source_ref"], name: "index_procuring_tasks_on_source_type_and_source_ref"
  end

  create_table "supplier_procedures", force: :cascade do |t|
    t.string "type", null: false
    t.string "source_id", null: false
    t.string "supplier_ref", null: false
    t.text "value", null: false
    t.integer "state", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["type", "source_id", "supplier_ref"], name: "index_unique_supplier_procedures", unique: true
  end

end
