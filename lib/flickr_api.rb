class FlickrAPI
  FlickRaw.api_key = "22229fa83164fe61cb46748c4b741dc2"
  FlickRaw.shared_secret = "c5c7b620d1203b4d"

  def self.search(latitude, longitude, min_timestamp, max_timestamp)
    flickr.photos.search(
      min_taken_date: min_timestamp.to_i,
      max_taken_date: max_timestamp.to_i,
      lat: latitude,
      lon: longitude,
      radius: 0.5#km TODO magic number
    )
  end

  def self.get_info(photo_id, secret)
    flickr.photos.getInfo(photo_id: photo_id, secret: secret)
  end
end