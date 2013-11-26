# TODO: this class could use some refactoring

require 'lastfm_xml'

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
  def self.artist_getEvents_all(id, options={})
    options[:artist] = id
    result = get('artist.getEvents', options)["events"]["event"] rescue []
    return [] if result.nil?
    result.is_a?(Array) ? result : [result]
  end

  # Number of past events
  def self.artist_getPastEvents_count(id)
    resp = get('artist.getPastEvents', artist: id, limit: 1)["events"]["@attr"]["total"].to_i rescue 0
  end

  # Get all past events up to a limit
  def self.artist_getPastEvents_all(id, limit=nil)
    result = get('artist.getPastEvents', artist: id, limit: limit)["events"]["event"] #rescue []
    return [] if result.nil?
    result.is_a?(Array) ? result : [result]
  end

  # Search for an artist
  def self.artist_search(term)
    return [] if term.blank?
    result = get('artist.search', artist: term)["results"]["artistmatches"]["artist"]
    return [] if result.nil?
    result.is_a?(Array) ? result : [result]
  end

  # Event info
  def self.event_getInfo(id)
    get('event.getInfo', event: id)["event"]
  end

  # Get upcoming events for latitude and longitude
  # radius is in miles, gets converted to km for lastfm
  def self.geo_getEvents(latitude, longitude, radius, options={})
    options.merge!({lat: latitude, long: longitude, distance: 1.61*radius})
    result = get('geo.getEvents', options)["events"]["event"] rescue []
    return [] if result.nil?
    result.is_a?(Array) ? result : [result]
  end

  # Get upcoming events count for latitude and longitude
  # radius is in miles, gets converted to km for lastfm
  def self.geo_getEvents_count(latitude, longitude, radius, options={})
    options.merge!({lat: latitude, long: longitude, distance: 1.61*radius, limit: 1})
    events_count = get('geo.getEvents', options)["events"]["@attr"]["total"].to_i rescue 0

    if options[:exclude_todays_events]
      options[:limit] = 50
      events = self.geo_getEvents(latitude, longitude, radius, options)
      todays_events_count = events.keep_if { |e| Date.parse(e['startDate']) == Date.today }.length
      events_count -= todays_events_count
    end
    events_count
  end

  private

    def self.get(method, params=nil)
      params ||= {}
      params[:method] = method

      # If the artist name includes an ampersand, then compensate for Lastfm's API failure to send
      # back a valid JSON file or a valid XML file (although at least it sends fix-able XML)
      # Issue only appears when getting past events
      if method == 'artist.getPastEvents' && params[:artist].include?('&')
        params[:api_key] = API_KEY
        response = Faraday.get 'http://ws.audioscrobbler.com/2.0', params

        LastfmXML.new(response.body, params[:artist]).convert
      else
        conn.get('2.0', params).body
      end
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