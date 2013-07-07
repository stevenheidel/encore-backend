# TODO: this class could use some refactoring

class LastfmAPI
  API_KEY = "89fba2b42503c2bedb38d545a8d462fa"

  # Artist info
  def self.artist_getInfo(id)
    get('artist.getInfo', artist: id)["artist"]
  end

  # Number of future events
  def self.artist_getEvents_count(id)
    get('artist.getEvents', artist: id, limit: 1)["events"]["@attr"]["total"].to_i rescue 0
  end

  # Get all future events up to a limit
  def self.artist_getEvents_all(id, limit=nil)
    limit ||= self.artist_getEvents_count(id)
    limit == 0 ? [] : get('artist.getEvents', artist: id, limit: limit)["events"]["event"]
  end

  # Number of past events
  def self.artist_getPastEvents_count(id)
    get('artist.getPastEvents', artist: id, limit: 1)["events"]["@attr"]["total"].to_i rescue 0
  end

  # Get all past events up to a limit
  def self.artist_getPastEvents_all(id, limit=nil)
    limit ||= self.artist_getPastEvents_count(id)
    limit == 0 ? [] : get('artist.getPastEvents', artist: id, limit: limit)["events"]["event"]
  end

  # Search for an artist
  def self.artist_search(term)
    get('artist.search', artist: term)["results"]["artistmatches"]["artist"]
  end

  # Event info
  def self.event_getInfo(id)
    get('event.getInfo', event: id)["event"]
  end

  # Get upcoming events for a location
  def self.geo_getEvents(location)
    get('geo.getEvents', location: location)["events"]["event"]
  end

  private

    def self.get(method, params=nil)
      params ||= {}
      params[:method] = method
      conn.get('2.0', params).body
    end

    def self.conn
      @@conn ||= Faraday.new(
        url: 'http://ws.audioscrobbler.com', params: {
          api_key: API_KEY,
          format: 'json'
        }
      ) do |conn|
        # response middlewares are processed in reverse order
        conn.response :json

        conn.adapter Faraday.default_adapter
      end
    end
end