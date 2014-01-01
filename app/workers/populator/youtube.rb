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
  
  def self.valid_date?(date, string)
    date_formats = [:long, :long_ordinal, :number, :db, :rfc822]
    date_formats.each {|date_format| #to_s
      return true if string.downcase.include?( date.to_s(date_format).downcase )
    }
    
    date_formats, base_formats = [], [
      '%Y/%m/%d', '%Y/%d/%m', '%Y-%m-%d', '%Y.%m.%d', '%m-%d-%Y', '%b-%d-%Y', '%b. %d, %Y', '%d/%m/%Y','%m/%d/%Y', 
      '%b %d,%Y', '%b %d, %Y', '%b %d.%Y', '%m %d %Y', '%b %d %Y'
    ]
    # permutations of date format strings
    date_formats = base_formats
    date_formats|= base_formats.collect {|f| f.gsub('%d', '%e') }
    date_formats|= base_formats.collect {|f| f.gsub('%b', '%B') }
    date_formats|= base_formats.collect {|f| f.gsub('%Y', '%y') }
    
    # date_formats.each {|f| p date.strftime(f) } #for testing
    date_formats.compact.each {|date_format| #strftime
      return true if string.include?( date.strftime(date_format).downcase )
    }
    
    false
  end

  private

    def valid_video?(title, description, name, venue, city, date)
      string = "#{title} - #{description}".downcase

      return false unless string.include?(name.downcase)
      return false unless string.include?(city.downcase) || string.include?(venue.downcase)
      
      Populator::Youtube.valid_date?(date, string)
    end
end