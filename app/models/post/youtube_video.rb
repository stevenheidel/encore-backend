# == Schema Information
#
# Table name: youtube_videos
#
#  id         :uuid             not null, primary key
#  caption    :string(255)
#  link       :string(255)
#  image_url  :string(255)
#  user_name  :string(255)
#  event_id   :uuid
#  created_at :datetime
#  updated_at :datetime
#

class Post::YoutubeVideo < ActiveRecord::Base
  include Concerns::Postable
  
  def self.build_from_response(response)
    self.new(
      caption: response.title,
      link: response.media_content[0].url,
      image_url: response.thumbnails[2].url, # [2] is the hq default
      user_name: response.author.name
    )
  end

  # Default picture
  def user_profile_picture
    "http://on.encore.fm/assets/public/applogo.png"
  end

  def type
    :youtube_video
  end
end
