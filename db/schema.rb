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

ActiveRecord::Schema.define(version: 20180210130059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "appquestions", force: :cascade do |t|
    t.string "name", null: false
    t.string "text", null: false
    t.string "field_type", null: false
    t.string "field_options"
    t.boolean "enabled", default: true, null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_appquestions_on_name", unique: true
  end

  create_table "playerappanswers", force: :cascade do |t|
    t.string "name", null: false
    t.string "question", null: false
    t.string "answer", null: false
    t.string "position", default: "0", null: false
    t.bigint "playerapp_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playerapp_id"], name: "index_playerappanswers_on_playerapp_id"
  end

  create_table "playerapps", force: :cascade do |t|
    t.string "player_name", null: false
    t.string "player_realm", null: false
    t.string "player_bnettag"
    t.string "player_class", null: false
    t.string "player_spec", null: false
    t.string "player_links"
    t.string "viewkey"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string "name", null: false
    t.jsonb "settings", default: "{}", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_settings_on_name", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.integer "access_level", default: 0
    t.string "token"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "playerappanswers", "playerapps", on_delete: :cascade
end
