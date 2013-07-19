class Post::YoutubeVideo < Post
	field :description, type: String
	field :thumbnail_link, type: String
	field :date, type: DateTime
end