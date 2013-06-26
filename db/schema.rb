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

ActiveRecord::Schema.define(version: 20130626141649) do

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

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "artists", force: true do |t|
    t.string   "name"
    t.integer  "songkick_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artists", ["songkick_uuid"], name: "index_artists_on_songkick_uuid", using: :btree

  create_table "attendances", force: true do |t|
    t.integer  "concert_id"
    t.integer  "user_id"
    t.integer  "who_referred"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendances", ["concert_id"], name: "index_attendances_on_concert_id", using: :btree
  add_index "attendances", ["user_id"], name: "index_attendances_on_user_id", using: :btree

  create_table "concerts", force: true do |t|
    t.string   "name"
    t.integer  "venue_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "artist_id"
    t.boolean  "populated"
    t.integer  "songkick_uuid"
  end

  add_index "concerts", ["artist_id"], name: "index_concerts_on_artist_id", using: :btree
  add_index "concerts", ["songkick_uuid"], name: "index_concerts_on_songkick_uuid", using: :btree
  add_index "concerts", ["venue_id"], name: "index_concerts_on_venue_id", using: :btree

  create_table "flickr_photos", force: true do |t|
    t.integer  "flickr_uuid",   limit: 8
    t.string   "flickr_secret"
    t.string   "link"
    t.string   "image_url"
    t.integer  "concert_id"
    t.string   "title"
    t.text     "description"
    t.string   "user_name"
    t.string   "user_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flickr_photos", ["flickr_uuid"], name: "index_flickr_photos_on_flickr_uuid", using: :btree

  create_table "instagram_locations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "venue_id"
    t.integer  "instagram_uuid"
    t.string   "name"
  end

  add_index "instagram_locations", ["instagram_uuid"], name: "index_instagram_locations_on_instagram_uuid", using: :btree
  add_index "instagram_locations", ["venue_id"], name: "index_instagram_locations_on_venue_id", using: :btree

  create_table "instagram_photos", force: true do |t|
    t.string   "instagram_uuid"
    t.text     "caption"
    t.string   "link"
    t.string   "image_url"
    t.integer  "concert_id"
    t.string   "user_name"
    t.string   "user_profile_picture"
    t.string   "user_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instagram_photos", ["concert_id"], name: "index_instagram_photos_on_concert_id", using: :btree
  add_index "instagram_photos", ["instagram_uuid"], name: "index_instagram_photos_on_instagram_uuid", using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "setlist_songs", force: true do |t|
    t.string   "name"
    t.string   "itunes_link"
    t.string   "concert_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "setlist_songs", ["concert_id"], name: "index_setlist_songs_on_concert_id", using: :btree

  create_table "user_photos", force: true do |t|
    t.integer  "concert_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "user_photos", ["concert_id"], name: "index_user_photos_on_concert_id", using: :btree
  add_index "user_photos", ["user_id"], name: "index_user_photos_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.integer  "facebook_uuid"
    t.string   "oauth_string"
    t.datetime "oauth_expiry"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["facebook_uuid"], name: "index_users_on_facebook_uuid", unique: true, using: :btree

  create_table "venues", force: true do |t|
    t.string   "name"
    t.decimal  "latitude",      precision: 10, scale: 6
    t.decimal  "longitude",     precision: 10, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
    t.integer  "songkick_uuid"
  end

  add_index "venues", ["songkick_uuid"], name: "index_venues_on_songkick_uuid", using: :btree

end
