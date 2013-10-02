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

ActiveRecord::Schema.define(version: 20131001000000) do

  create_table "artists", id: false, force: true do |t|
    t.uuid   "id",        null: false
    t.string "lastfm_id"
    t.string "name"
    t.string "website"
    t.string "url"
    t.string "mbid"
  end

  create_table "artists_events", id: false, force: true do |t|
    t.uuid "id",        null: false
    t.uuid "artist_id"
    t.uuid "event_id"
  end

  create_table "events", id: false, force: true do |t|
    t.uuid     "id",               null: false
    t.string   "lastfm_id"
    t.string   "name"
    t.string   "website"
    t.string   "url"
    t.string   "flickr_tag"
    t.string   "headliner"
    t.datetime "start_date"
    t.datetime "local_start_time"
    t.string   "tickets_url"
    t.uuid     "venue_id"
  end

  create_table "events_users", id: false, force: true do |t|
    t.uuid "id",       null: false
    t.uuid "event_id"
    t.uuid "user_id"
  end

  create_table "flags", id: false, force: true do |t|
    t.uuid   "id",      null: false
    t.string "type"
    t.uuid   "user_id"
    t.uuid   "post_id"
  end

  create_table "flickr_photos", id: false, force: true do |t|
    t.uuid    "id",            null: false
    t.integer "flickr_uuid"
    t.string  "flickr_secret"
    t.string  "link"
    t.string  "image_url"
    t.string  "title"
    t.string  "description"
    t.string  "user_name"
    t.string  "user_uuid"
    t.uuid    "event_id"
  end

  create_table "friend_visitors", id: false, force: true do |t|
    t.uuid "id",        null: false
    t.uuid "user_id"
    t.uuid "friend_id"
    t.uuid "event_id"
  end

  create_table "instagram_locations", id: false, force: true do |t|
    t.uuid     "id",             null: false
    t.string   "name"
    t.integer  "instagram_uuid"
    t.uuid     "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instagram_photos", id: false, force: true do |t|
    t.uuid   "id",                   null: false
    t.string "instagram_uuid"
    t.string "caption"
    t.string "link"
    t.string "image_url"
    t.string "user_name"
    t.string "user_profile_picture"
    t.string "user_uuid"
    t.uuid   "event_id"
  end

  create_table "lastfm_images", id: false, force: true do |t|
    t.uuid     "id",                    null: false
    t.string   "size"
    t.string   "url"
    t.uuid     "lastfm_imageable_id"
    t.string   "lastfm_imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_photos", id: false, force: true do |t|
    t.uuid "id",      null: false
    t.uuid "user_id"
  end

  create_table "users", id: false, force: true do |t|
    t.uuid     "id",               null: false
    t.integer  "facebook_id"
    t.string   "oauth_string"
    t.datetime "oauth_expiry"
    t.string   "name"
    t.boolean  "invite_sent"
    t.datetime "invite_timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", id: false, force: true do |t|
    t.uuid   "id",         null: false
    t.string "lastfm_id"
    t.string "name"
    t.string "website"
    t.string "url"
    t.string "city"
    t.string "country"
    t.string "street"
    t.string "postalcode"
  end

end
