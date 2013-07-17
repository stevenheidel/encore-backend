class Lastfm::Event < Lastfm::Base
  def methods
    super + [:flickr_tag, :headliner, :start_date]
  end

  def artists
    @artists ||= (
      a = @json["artists"]["artist"]

      # Artists is an array for events with multiple artists, otherwise it's a String
      a.kind_of?(String) ? [a] : a
    )
  end

  def venue
    return nil unless @json["venue"]
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

  def date
    start_date.to_date
  end

  # TODO: DRY this up with lastfmable
  def image_url
    @json["image"].last["#text"]
  end
end
