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

  # TODO: change to Sidekiq workers or something
  def self.artist_gigography(artist_id, all=false)
    if all
      resp = conn.get("artists/#{artist_id}/gigography.json").body.resultsPage
      pages = (resp.totalEntries / resp.perPage.to_f).ceil
    else
      pages = 1
    end
    
    results = []
    1.upto(pages) do |page|
      results += conn.get("artists/#{artist_id}/gigography.json", page: page).body.resultsPage.results.event
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

      conn.adapter Faraday.default_adapter
    end
  end
end