class EchonestAPI
  API_KEY = "PFAMHVK036M53HDVZ"

  def self.suggest(search)
    conn.get("artist/suggest", {name: search}).body.response.artists
  end

  def self.get_songkick_id(echonest_id)
    resp = conn.get("artist/profile", {id: echonest_id, bucket: 'id:songkick'})
    resp.body.response.artist.foreign_ids[0].foreign_id.split(':').last.to_i
  end

  private

  def self.conn
    @@conn ||= Faraday.new(
      url: 'http://developer.echonest.com/api/v4', params: {api_key: API_KEY}
    ) do |conn|
      # response middlewares are processed in reverse order
      conn.response :mashify
      conn.response :json

      conn.adapter Faraday.default_adapter
    end
  end
end