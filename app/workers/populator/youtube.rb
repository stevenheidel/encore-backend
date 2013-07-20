require 'youtube_api'

class Populator::Youtube < Populator::Base
  def perform(event_id)
    event = Event.find(event_id)

    query = "#{event.name} #{event.venue.city} #{event.local_date.strftime('%B %-d %Y')}"

    YoutubeAPI.search(query).each do |result|
      if valid_video?(result.title, result.description, 
          event.name, event.venue.name, event.venue.city, event.local_date)
        event.posts << Post::YoutubeVideo.build_from_response(result)
      end
    end
  end

  private

    def valid_video?(title, description, name, venue, city, date)
      string = "#{title} - #{description}".downcase

      return false unless string.include?(name.downcase)
      return false unless string.include?(city.downcase) || string.include?(venue.downcase)

      true
    end
end