class YoutubeAPI
	def self.search(query)
		client.videos_by(query: query, per_page: 5).videos
	end
	
	def self.client
		@@client ||= YouTubeIt::Client.new(dev_key: 'AIzaSyBb2jhht3D1wwdbQ-4FrZOaH8wKAl31mZw' )
	end
end