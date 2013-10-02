class YoutubeVideos < ActiveRecord::Migration
  def change
    create_table :youtube_videos, id: :uuid do |t|
      t.string :caption
      t.string :link
      t.string :image_url
      t.string :user_name

      t.uuid :event_id

      t.timestamps
    end
  end
end
