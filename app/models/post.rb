class Post
  def self.find(post_id)
    [
      Post::FlickrPhoto.find_by_id(post_id),
      Post::InstagramPhoto.find_by_id(post_id),
      Post::YoutubeVideo.find_by_id(post_id)
    ].compact.first
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