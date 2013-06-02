class InstagramAPI
  Instagram.configure do |config|
    config.client_id = "36887e12ddbc416fa4b3e84e899da701"
    config.client_secret = "652b4bd17580438485ed278fc4428c7f"
  end

  def self.instagram_locations(latitude, longitude)
    Instagram.location_search(latitude, longitude)
  end
end