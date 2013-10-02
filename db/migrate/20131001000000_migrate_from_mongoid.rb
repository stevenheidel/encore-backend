class MigrateFromMongoid < ActiveRecord::Migration
  enable_extension 'uuid-ossp'

  def change
    create_table :instagram_locations, id: :uuid do |t|
      t.string :name
      t.integer :instagram_uuid

      t.uuid :venue_id

      t.timestamps
    end

    create_table :lastfm_images, id: :uuid do |t|
      t.string :size
      t.string :url

      t.uuid :lastfm_imageable_id
      t.string :lastfm_imageable_type

      t.timestamps
    end

    create_table :users, id: :uuid do |t|
      t.integer :facebook_id
      t.string :oauth_string
      t.datetime :oauth_expiry
      t.string :name
      t.boolean :invite_sent
      t.datetime :invite_timestamp

      t.timestamps
    end

    create_table :events_users, id: :uuid do |t|
      t.uuid :event_id
      t.uuid :user_id
    end

    create_table :friend_visitors, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :friend_id
      t.uuid :event_id
    end

    create_table :flags, id: :uuid do |t|
      t.string :type

      t.uuid :user_id
      t.uuid :post_id
    end

    create_table :flickr_photos, id: :uuid do |t|
      t.integer :flickr_uuid
      t.string :flickr_secret
      t.string :link
      t.string :image_url
      t.string :title
      t.string :description
      t.string :user_name
      t.string :user_uuid

      t.uuid :event_id
    end

    create_table :instagram_photos, id: :uuid do |t|
      t.string :instagram_uuid
      t.string :caption
      t.string :link
      t.string :image_url
      t.string :user_name
      t.string :user_profile_picture
      t.string :user_uuid

      t.uuid :event_id
    end

    create_table :user_photos, id: :uuid do |t|
      t.uuid :user_id
    end

    create_table :artists, id: :uuid do |t|
      t.string :lastfm_id
      t.string :name
      t.string :website
      t.string :url

      t.string :mbid
    end

    create_table :events, id: :uuid do |t|
      t.string :lastfm_id
      t.string :name
      t.string :website
      t.string :url

      t.string :flickr_tag
      t.string :headliner
      t.datetime :start_date
      t.datetime :local_start_time
      t.string :tickets_url

      t.uuid :venue_id
    end

    create_table :venues, id: :uuid do |t|
      t.string :lastfm_id
      t.string :name
      t.string :website
      t.string :url

      t.string :city
      t.string :country
      t.string :street
      t.string :postalcode
    end

    create_table :artists_events, id: :uuid do |t|
      t.uuid :artist_id
      t.uuid :event_id
    end
  end

  def up
    add_attachment :user_photos, :photo
  end

  def down
    remove_attachment :user_photos, :photo
  end
end