class InstagramAPI
  Instagram.configure do |config|
    config.client_id = "36887e12ddbc416fa4b3e84e899da701"
    config.client_secret = "652b4bd17580438485ed278fc4428c7f"
  end

  def self.location_search(latitude, longitude)
    Instagram.location_search(latitude, longitude)
  end

  # TODO pass through a hash for min, max, etc.
  def self.location_recent_media(location_id, min_timestamp, max_timestamp, max_id=nil)
    hash = {}
    hash[:min_timestamp] = min_timestamp.to_i # to_i converts to a Unix timestamp
    hash[:max_timestamp] = max_timestamp.to_i
    hash[:max_id] = max_id if max_id

    Instagram.location_recent_media(location_id, hash)
  end

  def self.media_search(latitude, longitude, min_timestamp, max_timestamp)
    Instagram.media_search(
      latitude,
      longitude,
      min_timestamp: min_timestamp.to_i,
      max_timestamp: max_timestamp.to_i
    )
  end
end