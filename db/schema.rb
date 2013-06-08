# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130608041032) do

  create_table "admins", force: true do |t|
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "artists", force: true do |t|
    t.string   "name"
    t.integer  "songkick_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendances", force: true do |t|
    t.integer  "concert_id"
    t.integer  "user_id"
    t.integer  "who_referred"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "concerts", force: true do |t|
    t.string   "name"
    t.integer  "venue_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "eventful_id"
    t.integer  "artist_id"
    t.boolean  "populated"
  end

  create_table "instagram_locations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "venue_id"
  end

  create_table "instagram_photos", force: true do |t|
    t.string   "instagram_id"
    t.text     "caption"
    t.string   "link"
    t.string   "image_url"
    t.integer  "concert_id"
    t.string   "user_name"
    t.string   "user_profile_picture"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories"

  create_table "setlist_songs", force: true do |t|
    t.string   "name"
    t.string   "itunes_link"
    t.string   "concert_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_capsules", force: true do |t|
    t.boolean  "populated"
    t.integer  "concert_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_photos", force: true do |t|
    t.string   "concert_id"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "facebook_uuid"
    t.string   "oauth_string"
    t.datetime "oauth_expiry"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["facebook_uuid"], name: "index_users_on_facebook_uuid", unique: true

  create_table "venues", force: true do |t|
    t.string   "name"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
    t.string   "eventful_id"
  end

end
