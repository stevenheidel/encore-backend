class InstagramAPI
  CLIENT_IDS = %w(
    36887e12ddbc416fa4b3e84e899da701
    aa57a8dca1cb4f77964e965e1a4f08de
    6c92f9678efd40c1abee31d058735188
    4d55664c6cee404d8ef5757da4d0a04f
    b2755d92c1874a5b9ffdc91c345a29f8
  )

  def self.location_search(latitude, longitude)
    get('locations/search', lat: latitude, lng: longitude).data
  end

  def self.foursquare_location(foursquare_id)
    get('locations/search', foursquare_v2_id: foursquare_id).data
  end

  # TODO pass through a hash for min, max, etc.
  def self.location_recent_media(location_id, min_timestamp, max_timestamp, max_id=nil)
    hash = {}
    hash[:min_timestamp] = min_timestamp.to_i # to_i converts to a Unix timestamp
    hash[:max_timestamp] = max_timestamp.to_i
    hash[:max_id] = max_id if max_id

    get("locations/#{location_id}/media/recent", hash)
  end

  def self.media_search(latitude, longitude, min_timestamp, max_timestamp)
    hash = {
      lat: latitude,
      lng: longitude,
      min_timestamp: min_timestamp.to_i,
      max_timestamp: max_timestamp.to_i
    }
    get('media/search', hash)
  end

  private

    def self.get(method, params=nil)
      CLIENT_IDS.count.times do
        response = conn.get(method, params).body

        if response.code.to_i == 420
          switch_conns
        else
          return response
        end
      end

      raise "No Instagram Client IDs left to try"
    end

    def self.switch_conns
      @@current ||= 0

      @@current += 1

      if @@current >= CLIENT_IDS.size
        @@current = 0
      end

      @@conn = Faraday.new(
        url: 'https://api.instagram.com/v1', params: {
          client_id: CLIENT_IDS[@@current],
        }
      ) do |conn|
        # response middlewares are processed in reverse order
        conn.response :mashify
        conn.response :json

        conn.adapter Faraday.default_adapter
      end
    end

    def self.conn
      @@conn ||= Faraday.new(
        url: 'https://api.instagram.com/v1', params: {
          client_id: CLIENT_IDS[0],
        }
      ) do |conn|
        # response middlewares are processed in reverse order
        conn.response :mashify
        conn.response :json

        conn.adapter Faraday.default_adapter
      end
    end
end