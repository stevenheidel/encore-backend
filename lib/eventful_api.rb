class EventfulAPI
  APP_KEY = "2J3KXtGbfVvkp3ZZ"

  def self.url
    resp = conn.get 'events/search'

    resp.env[:url].to_s
  end

  # Return one event for now
  def self.search(name, location, date)
    date = DateTime.parse(date)
    formatted_date = date.strftime("%Y%m%d00-%Y%m%d00")

    resp = conn.get 'events/search', {
      keywords: name,
      location: location,
      date: formatted_date,
      category: 'concerts'
    }

    resp.body.events.event
  end

  private

  def self.conn
    @@conn ||= Faraday.new(
      url: 'http://api.eventful.com/json', params: {app_key: APP_KEY}
    ) do |conn|
      # response middlewares are processed in reverse order
      conn.response :mashify
      conn.response :json

      conn.adapter Faraday.default_adapter
    end
  end
end