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

ActiveRecord::Schema[7.1].define(version: 2024_03_07_174922) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "requests", force: :cascade do |t|
    t.bigint "user_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "serials", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "chat_id", null: false
    t.boolean "is_bot", default: false, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "language_code"
    t.boolean "enable_notifications", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_serials", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "serial_id"
    t.boolean "is_tracked", default: true, null: false
    t.string "source", null: false
    t.string "url", null: false
    t.string "endpoint", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serial_id"], name: "index_users_serials_on_serial_id"
    t.index ["user_id"], name: "index_users_serials_on_user_id"
  end

  add_foreign_key "requests", "users"
  add_foreign_key "users_serials", "serials"
  add_foreign_key "users_serials", "users"
end
