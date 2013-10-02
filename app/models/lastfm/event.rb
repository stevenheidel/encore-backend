# == Schema Information
#
# Table name: events
#
#  id               :uuid             not null, primary key
#  lastfm_id        :string(255)
#  name             :string(255)
#  website          :string(255)
#  url              :string(255)
#  flickr_tag       :string(255)
#  headliner        :string(255)
#  start_date       :datetime
#  local_start_time :datetime
#  tickets_url      :string(255)
#  venue_id         :uuid
#  created_at       :datetime
#  updated_at       :datetime
#  sidekiq_workers  :string(255)      default([])
#

class Lastfm::Event < Lastfm::Base
  def initialize(json)
    super(json)
    extract_tickets_url
  end

  def methods
    super + [:flickr_tag, :headliner, :start_date, :tickets_url]
  end

  attr_reader :tickets_url

  def artists
    @artists ||= (
      a = @json["artists"]["artist"]

      # Artists is an array for events with multiple artists, otherwise it's a String
      a.kind_of?(String) ? [a] : a
    )
  end

  def venue
    return nil unless @json["venue"] # sometimes events don't have venues
    @venue ||= Lastfm::Venue.new(@json["venue"])
  end

  # Override
  def name
    @json["title"]
  end

  def flickr_tag
    @json["tag"]
  end

  def headliner
    @json["artists"]["headliner"]
  end

  def start_date
    @json["startDate"]
  end

  def start_time
    start_date
  end

  def date
    start_date.to_date
  end

  def image_url
    @json["image"].last["#text"]
  end

  private
  def extract_tickets_url
    if(@json.is_a?(Hash))
      url_regexp = /https?:\/\/[-\w .\/?%&=;]+/
      urls = @json["description"].to_s.scan(url_regexp)
      urls.concat(@json["website"].to_s.scan(url_regexp))
      urls.concat(@json["tickets"].to_s.scan(url_regexp))
      if urls.present?
        tickets_urls = urls.select{|url| url.match(/ticket|sale|buy|purchase/)}
        @tickets_url = tickets_urls[0] if tickets_urls
      end
    end
  end
end
