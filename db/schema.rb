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

ActiveRecord::Schema[7.1].define(version: 2024_06_13_163357) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coin_varieties", force: :cascade do |t|
    t.integer "pcgs_id"
    t.string "name"
    t.integer "year"
    t.string "denomination"
    t.string "mintage"
    t.string "mint_mark"
    t.string "metal_content"
    t.float "diameter"
    t.string "edge"
    t.float "weight"
    t.string "designation"
    t.integer "population"
    t.string "pcgs_link"
    t.string "designer"
    t.text "pcgs_notes"
    t.integer "mint_type", default: 0, null: false
    t.json "images"
    t.integer "series_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["series_id"], name: "index_coin_varieties_on_series_id"
  end

  create_table "grade_values", force: :cascade do |t|
    t.integer "grade"
    t.float "value"
    t.integer "coin_variety_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_variety_id"], name: "index_grade_values_on_coin_variety_id"
  end

  create_table "series", force: :cascade do |t|
    t.string "name"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_url"
    t.index ["category_id"], name: "index_series_on_category_id"
  end

end
