# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_220_722_152_237) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "definitions", force: :cascade do |t|
    t.text "body"
    t.bigint "expression_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expression_id"], name: "index_definitions_on_expression_id"
  end

  create_table "expressions", force: :cascade do |t|
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "quotes", force: :cascade do |t|
    t.text "body"
    t.text "source"
    t.bigint "expression_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expression_id"], name: "index_quotes_on_expression_id"
  end

  create_table "user_preferences", force: :cascade do |t|
    t.string "periodicity", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_preferences_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "auth_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["auth_id"], name: "index_users_on_auth_id"
  end

  add_foreign_key "definitions", "expressions"
  add_foreign_key "quotes", "expressions"
  add_foreign_key "user_preferences", "users"
end
