require 'typhoeus/adapters/faraday'

class LastfmAPI
  API_KEY = "89fba2b42503c2bedb38d545a8d462fa"

  def self.artist_getInfo(id)
    get('artist.getInfo', artist: id).artist
  end

  # Number of past concerts
  def self.artist_getPastEvents_count(id)
    get('artist.getPastEvents', artist: id, limit: 1).events["@attr"]["total"].to_i
  end

  # Get all past events
  def self.artist_getPastEvents_all(id)
    limit = artist_getPastEvents_count(id)
    get('artist.getPastEvents', artist: id, limit: limit).events.event
  end

  def self.event_getInfo(id)
    get('event.getInfo', event: id).event
  end

  private

  def self.get(method, params)
    params[:method] = method
    conn.get('', params).body
  end

  def self.conn
    @@conn ||= Faraday.new(
      url: 'http://ws.audioscrobbler.com/2.0/', params: {
        api_key: API_KEY,
        format: 'json'
      }
    ) do |conn|
      # response middlewares are processed in reverse order
      conn.response :mashify
      conn.response :json

      conn.adapter :typhoeus
    end
  end
end