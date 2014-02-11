class Post
  def self.find(post_id)
    (Post::FlickrPhoto.find(post_id) + Post::InstagramPhoto.find(post_id) + 
      Post::YoutubeVideo.find(post_id)).first
  end

  def self.all_for_event(event_id)
    event = Event.find(event_id)

    event.flickr_photos + event.instagram_photos + event.youtube_videos
  end

  def self.flickr
    Post::FlickrPhoto
  end

  def self.instagram
    Post::InstagramPhoto
  end

  def self.youtube 
    Post::YoutubeVideo
  end
end