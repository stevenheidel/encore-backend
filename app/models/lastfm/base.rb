class Lastfm::Base
  def initialize(json)
    @json = json
  end

  # List of methods that correspond with fields in the database
  def methods
    [:lastfm_id, :name, :url, :website]
  end

  def lastfm_id
    @json["id"]
  end

  def name
    @json["name"]
  end

  def url
    @json["url"]
  end

  def website
    @json["website"]
  end

  def images
    @json["image"]
  end
end