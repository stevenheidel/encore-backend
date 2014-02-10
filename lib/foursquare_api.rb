class FoursquareAPI
  CLIENT_ID = "OANCCHMOA0UBCAISXWHIVEZE4QZWAPIZ5R3MB1UJ0CUEYC2W"
  CLIENT_SECRET = "A54NI2GGMB0EOPPUS5HQCTWR55PU31JMKNILGADHFLB0FIJD"

  def self.search_venues(venue_name, latitude, longitude)
    client.search_venues(v: 20140101, ll: "#{latitude},#{longitude}", query: venue_name, intent: 'match').venues
  end

  private

  def self.client
    @@client ||= Foursquare2::Client.new(:client_id => CLIENT_ID, :client_secret => CLIENT_SECRET)
  end
end