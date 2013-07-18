class InstagramAPI
  CLIENT_ID = "36887e12ddbc416fa4b3e84e899da701"

  def self.location_search(latitude, longitude)
    Instagram.location_search(latitude, longitude)
  end

  def self.foursquare_location(foursquare_id)
    Instagram.location_search(foursquare_id)
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

  private

    def self.conn
      @@conn ||= Faraday.new(
        url: 'https://api.instagram.com/v1', params: {
          client_id: CLIENT_ID,
        }
      ) do |conn|
        # response middlewares are processed in reverse order
        conn.response :mashify
        conn.response :json

        conn.adapter Faraday.default_adapter
      end
    end
end