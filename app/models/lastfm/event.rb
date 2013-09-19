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
    urls = @json["description"].scan(/https?:\/\/[-\w .\/?%&=;]+/)
    if urls.present?
      tickets_urls = urls.select{|url| url.match(/ticket|sale|buy|purchase/)}
      @tickets_url = tickets_urls[0] if tickets_urls
      @tickets_url = urls[0] unless @tickets_url
    end
  end
end
