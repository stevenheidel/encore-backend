require 'typhoeus/adapters/faraday'

class SongkickAPI
  APP_KEY = "0Zpbq2MQoAmjobgY"

  def self.full_search(concert_name, date, city)
    artist = self.artist_search(concert_name).first
    concerts = SongkickAPI.artist_gigography(artist.id, true)

    concerts.keep_if {|c| c.location.city.include?(city) }
  end

  def self.artist_search(query)
    conn.get("search/artists.json", query: query).body.resultsPage.results.artist
  end

  def self.artist_gigography(artist_id, all=false)
    responses = [conn.get("artists/#{artist_id}/gigography.json")]

    if all
      pages = (responses[0].body.resultsPage.totalEntries / responses[0].body.resultsPage.perPage.to_f).ceil

      conn.in_parallel do
        2.upto(pages) do |page|
          responses << conn.get("artists/#{artist_id}/gigography.json", page: page)
        end
      end
    end

    results = []
    responses.each do |r| 
      results += r.body.resultsPage.results.event
    end
    results
  end

  def self.get_event_by_id(event_id)
    conn.get("events/#{event_id}.json").body.resultsPage.results.event
  end

  private

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