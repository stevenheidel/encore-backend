

class YoutubeAPI
	
	
	def self.search(artist, city)
		client.videos_by(:query => "#{artist} #{city}", :categories => [:music], :page => 5, :per_page => 5, :fields => {:published  => ((Date.today - 30)..(Date.today))} ).videos
	end

	
	def self.client
		@@client ||= YouTubeIt::Client.new(:dev_key => 'AIzaSyBb2jhht3D1wwdbQ-4FrZOaH8wKAl31mZw' )
	end

end

