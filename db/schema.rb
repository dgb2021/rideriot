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

ActiveRecord::Schema.define(version: 2021_06_07_150729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attempts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "cycle_route_id", null: false
    t.time "start_time"
    t.time "end_time"
    t.boolean "completed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cycle_route_id"], name: "index_attempts_on_cycle_route_id"
    t.index ["user_id"], name: "index_attempts_on_user_id"
  end

  create_table "cycle_routes", force: :cascade do |t|
    t.string "name"
    t.string "start_point"
    t.string "end_point"
    t.string "way_points"
    t.float "distance"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_cycle_routes_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "comment"
    t.integer "rating"
    t.bigint "cycle_route_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cycle_route_id"], name: "index_reviews_on_cycle_route_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "route_tags", force: :cascade do |t|
    t.bigint "cycle_route_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cycle_route_id"], name: "index_route_tags_on_cycle_route_id"
    t.index ["tag_id"], name: "index_route_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "distance_cycled"
    t.integer "routes_completed"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attempts", "cycle_routes"
  add_foreign_key "attempts", "users"
  add_foreign_key "cycle_routes", "users"
  add_foreign_key "reviews", "cycle_routes"
  add_foreign_key "reviews", "users"
  add_foreign_key "route_tags", "cycle_routes"
  add_foreign_key "route_tags", "tags"
end
