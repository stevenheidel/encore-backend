class EventfulAPI
  APP_KEY = "2J3KXtGbfVvkp3ZZ"

  def self.full_search(name, location, date)
    begin
      date = DateTime.parse(date.to_s)
      formatted_date = date.strftime("%Y%m%d00-%Y%m%d00")
    rescue
      formatted_date = "Past"
    end

    resp = conn.get 'events/search', {
      keywords: name,
      location: location,
      date: formatted_date,
      category: 'concerts'
    }

    events = resp.body.events.event
    resp.body.total_items.to_i == 1 ? [events] : events
  end

  def self.get_event_by_id(eventful_id)
    resp = conn.get 'events/get', {
      id: eventful_id
    }

    resp.body
  end

  def self.get_venue_by_id(eventful_id)
    resp = conn.get 'venues/get', {
      id: eventful_id
    }

    resp.body
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