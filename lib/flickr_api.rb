class FlickrAPI
  FlickRaw.api_key = "22229fa83164fe61cb46748c4b741dc2"
  FlickRaw.shared_secret = "c5c7b620d1203b4d"

  def self.test(concert)
    File.open(Rails.root.join('public', 'flickr.html'), 'w') do |file|
      search(concert.venue.latitude, concert.venue.longitude, concert.start_time, concert.end_time).each do |photo|
        file.write "<img src='"
        file.write "http://farm#{photo.farm}.staticflickr.com/#{photo.server}/#{photo.id}_#{photo.secret}.jpg"
        file.write "' />\n"
      end
    end
  end

  def self.search(latitude, longitude, min_timestamp, max_timestamp)
    flickr.photos.search(
      min_taken_date: min_timestamp.to_i, 
      max_taken_date: max_timestamp.to_i,
      lat: latitude,
      lon: longitude,
      radius: 0.5#km TODO magic number
    )
  end
end