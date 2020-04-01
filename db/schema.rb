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

ActiveRecord::Schema.define(version: 2020_04_01_011328) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_statuses", id: :serial, force: :cascade do |t|
    t.integer "album_id"
    t.boolean "played"
    t.boolean "purchased"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albums", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.integer "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "genre", limit: 255
    t.string "album_art", limit: 255
    t.string "year", limit: 255
    t.text "editions"
  end

  create_table "artists", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "sort_name", limit: 255
  end

  create_table "meta_data", id: :serial, force: :cascade do |t|
    t.string "source", limit: 255
    t.text "data"
    t.integer "item_id"
    t.string "item_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_meta_data_on_item_id"
  end

  create_table "playlist_albums", id: :serial, force: :cascade do |t|
    t.integer "playlist_id"
    t.integer "album_id"
    t.integer "position", default: 0
  end

  create_table "playlists", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 128, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
