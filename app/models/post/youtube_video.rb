class Post::YoutubeVideo < Post
  def self.build_from_response(response)
    self.new(
      caption: response.title,
      link: response.media_content[0].url,
      image_url: response.thumbnails[2].url, # [2] is the hq default
      user_name: response.author.name
    )
  end
end