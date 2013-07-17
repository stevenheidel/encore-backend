

class YoutubeAPI
	
	
	def self.search(artist)
		client.videos_by(:query => artist, :categories => [:music], :page => 1, :per_page => 1, :fields => {:published  => ((Date.today - 30)..(Date.today))} )
	end

	
	def self.client
		@@client ||= YouTubeIt::Client.new(:dev_key => 'AIzaSyBb2jhht3D1wwdbQ-4FrZOaH8wKAl31mZw' )
	end

end