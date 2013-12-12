# == Schema Information
#
# Table name: artists
#
#  id                   :uuid             not null, primary key
#  lastfm_id            :string(255)
#  name                 :string(255)
#  website              :text
#  url                  :string(255)
#  mbid                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  past_event_freshness :datetime
#

class Artist < ActiveRecord::Base
  include Concerns::Lastfmable

  has_and_belongs_to_many :events, -> { uniq }

  def self.search(term)
    LastfmAPI.artist_search(term).map { |a| Lastfm::Artist.new(a) }
  end

  # Name and lastfm_id are synonyms
  def name
    self.lastfm_id
  end

  def past_events(geo=nil, options={})
    # Check if database is current
    if past_event_freshness && (DateTime.now - self.past_event_freshness.to_datetime).days < 7
      # return only those in the correct radius
      events = self.events.past.in_radius(geo) if geo.present?
    else
      events = retrieve_past_events

      Saver::PastEvents.perform_async(self.lastfm_id) # send to worker to save to database

      # return only those in the correct radius
      events.keep_if { |e| e.venue.try(:in_radius?, geo) } if geo.present?
    end

    events = events.first(options[:limit]) if options[:limit].present?
    events
  end

  # Returned as Lastfm::Event objects
  def retrieve_past_events
    lastfm_count = LastfmAPI.artist_getPastEvents_count(self.lastfm_id)

    # if not current, make array of Lastfm::Event objects from API call
    events = LastfmAPI.artist_getPastEvents_all(self.lastfm_id, lastfm_count).map do |e|
      Lastfm::Event.new(e)
    end
  end

  def future_events(geo=nil, options={})
    events = LastfmAPI.artist_getEvents_all(self.lastfm_id, options).map do |e|
      Lastfm::Event.new(e)
    end
    events.keep_if { |e| e.venue.try(:in_radius?, geo) } if geo.present?
    events
  end
end
