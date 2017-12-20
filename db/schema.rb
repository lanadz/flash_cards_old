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

ActiveRecord::Schema.define(version: 20171218073548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.boolean "is_default", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["is_default"], name: "index_categories_on_is_default"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "flash_cards", force: :cascade do |t|
    t.text "face"
    t.text "back"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.bigint "user_id"
    t.index ["category_id"], name: "index_flash_cards_on_category_id"
    t.index ["user_id"], name: "index_flash_cards_on_user_id"
  end

  create_table "learning_session_details", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "category_id"
    t.integer "correct_answers"
    t.integer "wrong_answers"
    t.integer "cards_amount"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.index ["category_id"], name: "index_learning_session_details_on_category_id"
    t.index ["started_at"], name: "index_learning_session_details_on_started_at"
    t.index ["user_id"], name: "index_learning_session_details_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "encrypted_password", null: false
    t.string "auth_token"
    t.datetime "auth_token_expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_token", "auth_token_expired_at"], name: "index_users_on_auth_token_and_auth_token_expired_at"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
