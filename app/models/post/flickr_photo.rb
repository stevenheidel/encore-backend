class Post::FlickrPhoto < Post
  field :flickr_uuid, type: Integer 
  field :flickr_secret, type: String 
  field :title, type: String
  field :description, type: String
  field :user_uuid, type: String

  # Builds an object from JSON returned by Flickr
  def self.build_from_hashie(hashie)
    self.new(
      flickr_uuid: hashie.id,
      flickr_secret: hashie.secret,
      link: hashie.urls[0]._content,
      image_url: "http://farm#{hashie.farm}.staticflickr.com/#{hashie.server}/#{hashie.id}_#{hashie.secret}.jpg",
      title: hashie.title,
      description: hashie.description,
      user_name: hashie.owner.realname,
      user_uuid: hashie.owner.nsid
    )
  end
end
