require 'multi_xml'
require 'active_support/core_ext/hash'

class LastfmXML
  def initialize(response, artist)
    @xml = response
    @artist = artist
  end

  def convert
    fix_xml
    parse_xml
  end

  def fix_xml
    # Change & in events url to be its percent code
    @xml = @xml.sub(/http:\/\/www\.last\.fm\/music\/.*\/\+events/) { |match| 
      match.gsub('&', '%26') 
    }
  end

  def parse_xml
    parse_root(MultiXml.parse(@xml))
  end

  def parse_root(x)
    x = x["lfm"]["events"]

    ret = {}
    ret["events"] = {}
    ret["events"]["event"] = parse_events(x)
    ret["events"]["@attr"] = parse_attr(x)

    ret
  end

  def parse_events(x)
    if x["event"].is_a?(Array)
      x["event"].map {|event| parse_event(event)}
    else
      parse_event(x["event"])
    end
  end

  def parse_attr(x)
    x.except("event")
  end

  def parse_event(x)
    x["venue"] = parse_venue(x["venue"])
    x["image"] = parse_images(x["image"])
    x
  end

  def parse_venue(x)
    x["location"]["geo:point"] = x["location"]["point"]
    x["location"]["geo:point"]["geo:lat"] = x["location"]["geo:point"]["lat"]
    x["location"]["geo:point"]["geo:long"] = x["location"]["geo:point"]["long"]
    x["location"].except!("point")
    x["location"]["geo:point"].except!("lat", "long")

    x["image"] = parse_images(x["image"])

    x
  end

  def parse_images(x)
    x.map do |image|
      image["#text"] = image["__content__"] || ""
      image.except("__content__")
    end
  end
end