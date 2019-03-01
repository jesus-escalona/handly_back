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

ActiveRecord::Schema.define(version: 2019_02_22_184945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "email_verified"
    t.string "phone_number"
    t.string "avatar", default: "https://mir-s3-cdn-cf.behance.net/project_modules/disp/84c20033850498.56ba69ac290ea.png"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.bigint "client_id"
    t.string "picture"
    t.string "item_type"
    t.decimal "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_items_on_client_id"
  end

  create_table "movers", force: :cascade do |t|
    t.string "company_name"
    t.string "admin_name"
    t.text "address"
    t.boolean "verified"
    t.string "logo"
    t.boolean "insured"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movings", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "mover_id"
    t.decimal "origin_lat", precision: 14, scale: 8
    t.decimal "origin_lng", precision: 14, scale: 8
    t.string "origin_administrative"
    t.string "origin_address"
    t.decimal "destination_lat", precision: 14, scale: 8
    t.decimal "destination_lng", precision: 14, scale: 8
    t.string "destination_administrative"
    t.string "destination_address"
    t.datetime "moving_time"
    t.decimal "estimate", precision: 16, scale: 2
    t.decimal "final_price", precision: 16, scale: 2
    t.integer "moving_rating"
    t.text "moving_review"
    t.decimal "distance", precision: 16, scale: 2
    t.string "moving_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_movings_on_client_id"
    t.index ["mover_id"], name: "index_movings_on_mover_id"
  end

  add_foreign_key "items", "clients"
  add_foreign_key "movings", "clients"
  add_foreign_key "movings", "movers"
end
