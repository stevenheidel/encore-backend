require 'typhoeus/adapters/faraday'

class SongkickAPI
  APP_KEY = "0Zpbq2MQoAmjobgY"

  def self.artist_search(query)
    conn.get("search/artists.json", query: query).body.resultsPage.results.artist
  end

  def self.artist_gigography(artist_id, all=false)
    first_or_all_events("artists/#{artist_id}/gigography.json", all)
  end

  def self.artist_gigography_city(artist_id, city)
    artist_gigography(artist_id, true).keep_if {|c| c.location.city.include?(city)}
  end

  def self.artist_upcoming(artist_id, all=false)
    first_or_all_events("artists/#{artist_id}/calendar.json", all)
  end

  def self.artist_upcoming_city(artist_id, city)
    artist_upcoming(artist_id, true).keep_if {|c| c.location.city.include?(city)}
  end

  def self.get_event_by_id(event_id)
    conn.get("events/#{event_id}.json").body.resultsPage.results.event
  end

  def self.location_search(query)
    conn.get("search/locations.json", query: query).body.resultsPage.results.location
  end

  def self.metroarea_upcoming(metroarea_id)
    conn.get("metro_areas/#{metroarea_id}/calendar.json").body.resultsPage.results.event
  end

  private

  # paginate through the results in parallel
  def self.first_or_all_events(url, all=false)
    responses = [conn.get(url)]
    return [] if responses[0].body.resultsPage.totalEntries == 0

    if all
      pages = (responses[0].body.resultsPage.totalEntries / responses[0].body.resultsPage.perPage.to_f).ceil

      conn.in_parallel do
        2.upto(pages) do |page|
          responses << conn.get(url, page: page)
        end
      end
    end

    results = []
    responses.each do |r|
      results += r.body.resultsPage.results.event
    end
    results
  end

  def self.conn
    @@conn ||= Faraday.new(
      url: 'http://api.songkick.com/api/3.0', params: {apikey: APP_KEY}
    ) do |conn|
      # response middlewares are processed in reverse order
      conn.response :mashify
      conn.response :json

      conn.adapter :typhoeus
    end
  end
end