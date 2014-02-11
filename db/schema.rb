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

ActiveRecord::Schema.define(version: 20140211081446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "artists", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "lastfm_id"
    t.string   "name"
    t.text     "website"
    t.string   "url"
    t.string   "mbid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "past_event_freshness"
    t.string   "image_url_cached"
  end

  add_index "artists", ["lastfm_id"], name: "index_artists_on_lastfm_id", unique: true, using: :btree

  create_table "artists_events", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid "artist_id"
    t.uuid "event_id"
  end

  add_index "artists_events", ["artist_id", "event_id"], name: "index_artists_events_on_artist_id_and_event_id", using: :btree
  add_index "artists_events", ["event_id"], name: "index_artists_events_on_event_id", using: :btree

  create_table "events", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "lastfm_id"
    t.string   "name"
    t.text     "website"
    t.string   "url"
    t.string   "flickr_tag"
    t.string   "headliner"
    t.datetime "start_date"
    t.datetime "local_start_time"
    t.text     "tickets_url"
    t.uuid     "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "sidekiq_workers"
    t.integer  "users_count",      default: 0
    t.string   "image_url_cached"
  end

  add_index "events", ["lastfm_id"], name: "index_events_on_lastfm_id", unique: true, using: :btree
  add_index "events", ["start_date"], name: "index_events_on_start_date", using: :btree
  add_index "events", ["users_count"], name: "index_events_on_users_count", using: :btree
  add_index "events", ["venue_id"], name: "index_events_on_venue_id", using: :btree

  create_table "events_users", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid "event_id"
    t.uuid "user_id"
  end

  add_index "events_users", ["event_id", "user_id"], name: "index_events_users_on_event_id_and_user_id", using: :btree
  add_index "events_users", ["user_id"], name: "index_events_users_on_user_id", using: :btree

  create_table "flags", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "type"
    t.uuid     "user_id"
    t.uuid     "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flickr_photos", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "flickr_uuid"
    t.string   "flickr_secret"
    t.string   "link"
    t.string   "image_url"
    t.string   "title"
    t.string   "description"
    t.string   "user_name"
    t.string   "user_uuid"
    t.uuid     "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flickr_photos", ["event_id"], name: "index_flickr_photos_on_event_id", using: :btree

  create_table "friend_visitors", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "user_id"
    t.uuid     "friend_id"
    t.uuid     "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friend_visitors", ["event_id"], name: "index_friend_visitors_on_event_id", using: :btree
  add_index "friend_visitors", ["friend_id"], name: "index_friend_visitors_on_friend_id", using: :btree
  add_index "friend_visitors", ["user_id"], name: "index_friend_visitors_on_user_id", using: :btree

  create_table "instagram_locations", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.integer  "instagram_uuid"
    t.uuid     "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instagram_locations", ["venue_id"], name: "index_instagram_locations_on_venue_id", using: :btree

  create_table "instagram_photos", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "instagram_uuid"
    t.string   "caption"
    t.string   "link"
    t.string   "image_url"
    t.string   "user_name"
    t.string   "user_profile_picture"
    t.string   "user_uuid"
    t.uuid     "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instagram_photos", ["event_id"], name: "index_instagram_photos_on_event_id", using: :btree

  create_table "lastfm_images", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "size"
    t.string   "url"
    t.uuid     "lastfm_imageable_id"
    t.string   "lastfm_imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lastfm_images", ["lastfm_imageable_id", "lastfm_imageable_type"], name: "index_lastfm_images_on_imageable_id_and_imageable_type", using: :btree

  create_table "user_photos", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid "user_id"
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "facebook_id"
    t.string   "oauth_string"
    t.datetime "oauth_expiry"
    t.string   "name"
    t.boolean  "invite_sent"
    t.datetime "invite_timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "events_count",     default: 0
  end

  add_index "users", ["events_count"], name: "index_users_on_events_count", using: :btree
  add_index "users", ["facebook_id"], name: "index_users_on_facebook_id", unique: true, using: :btree

  create_table "venues", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "lastfm_id"
    t.string   "name"
    t.text     "website"
    t.string   "url"
    t.string   "city"
    t.string   "country"
    t.string   "street"
    t.string   "postalcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "image_url_cached"
  end

  add_index "venues", ["lastfm_id"], name: "index_venues_on_lastfm_id", unique: true, using: :btree
  add_index "venues", ["latitude"], name: "index_venues_on_latitude", using: :btree
  add_index "venues", ["longitude"], name: "index_venues_on_longitude", using: :btree

  create_table "youtube_videos", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "caption"
    t.string   "link"
    t.string   "image_url"
    t.string   "user_name"
    t.uuid     "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
