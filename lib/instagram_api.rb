class InstagramAPI
  Instagram.configure do |config|
    config.client_id = "36887e12ddbc416fa4b3e84e899da701"
    config.client_secret = "652b4bd17580438485ed278fc4428c7f"
  end

  def self.location_search(latitude, longitude)
    Instagram.location_search(latitude, longitude)
  end

  def self.location_recent_media(location_id, min_timestamp, max_timestamp)
    pp location_id, min_timestamp.to_i, max_timestamp.to_i
    Instagram.location_recent_media(
      location_id,
      min_timestamp: min_timestamp.to_i, # to_i converts to a Unix timestamp
      max_timestamp: max_timestamp.to_i
    )
  end
end