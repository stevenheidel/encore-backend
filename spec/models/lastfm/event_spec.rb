require 'spec_helper'

describe Lastfm::Event do
  let(:sample) do
    {"id"=>"2075035",
    "title"=>"First Gig",
    "artists"=>
     {"artist"=>"The Rolling Stones", "headliner"=>"The Rolling Stones"},
    "venue"=>
     {"id"=>"8788342",
      "name"=>"Marquee Club",
      "location"=>
       {"geo:point"=>{"geo:lat"=>"51.513403", "geo:long"=>"-0.133914"},
        "city"=>"London",
        "country"=>"United Kingdom",
        "street"=>"14 Upper Saint Martins Lane",
        "postalcode"=>"WC2H 9EF"},
      "url"=>"http://www.last.fm/venue/8788342+Marquee+Club",
      "website"=>"",
      "phonenumber"=>"",
      "image"=>
       [{"#text"=>"http://userserve-ak.last.fm/serve/34/2712130.jpg",
         "size"=>"small"},
        {"#text"=>"http://userserve-ak.last.fm/serve/64/2712130.jpg",
         "size"=>"medium"},
        {"#text"=>"http://userserve-ak.last.fm/serve/126/2712130.jpg",
         "size"=>"large"},
        {"#text"=>"http://userserve-ak.last.fm/serve/252/2712130.jpg",
         "size"=>"extralarge"},
        {"#text"=>
          "http://userserve-ak.last.fm/serve/_/2712130/Marquee+Club+normal_GCupperstmartin3.jpg",
         "size"=>"mega"}]},
    "startDate"=>"Fri, 12 Jul 1963 18:00:00",
    "description"=>
     "<div class=\"bbcode\">On 12 July 1962 the band played their first gig at the Marquee Club billed as &quot;The Rollin' Stones&quot;. The line-up was Jagger, Richards and Jones, along with Stewart on piano, Taylor on bass and Chapman on drums. Jones and Stewart wanted to play Chicago blues, but were agreeable to the Chuck Berry and Bo Diddley numbers of Jagger and Richards.[15] Bassist Bill Wyman joined in December 1962 and drummer Charlie Watts the following January 1963 to form the band's long-standing rhythm section.</div>",
    "image"=>
     [{"#text"=>"http://userserve-ak.last.fm/serve/34/7596573.jpg",
       "size"=>"small"},
      {"#text"=>"http://userserve-ak.last.fm/serve/64/7596573.jpg",
       "size"=>"medium"},
      {"#text"=>"http://userserve-ak.last.fm/serve/126/7596573.jpg",
       "size"=>"large"},
      {"#text"=>"http://userserve-ak.last.fm/serve/252/7596573.jpg",
       "size"=>"extralarge"}],
    "attendance"=>"1",
    "reviews"=>"0",
    "tag"=>"lastfm:event=2075035",
    "url"=>"http://www.last.fm/event/2075035+First+Gig",
    "website"=>"",
    "cancelled"=>"0"}
  end

  it "should create a new object" do
    le = Lastfm::Event.new(sample)
  end
end
