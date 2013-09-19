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
     "<div class=\"bbcode\">UNION EVENTS PROUDLY PRESENTS <br /><br />HERBERT GRÖNEMEYER<br /><a href=\"https://www.facebook.com/herbertgroenemeyer\" rel=\"nofollow\">https://www.facebook.com/herbertgroenemeyer</a><br /><br />FRIDAY SEPTEMBER 20, 2013<br />THE OPERA HOUSE<br />Doors 8:00 PM – 19+<br /><br />TICKETS ON SALE MONDAY JUNE 17<br /><a href=\"http://ticketf.ly/11UbDtS\" rel=\"nofollow\">http://ticketf.ly/11UbDtS</a><br />VIP Advance ticket (includes meet &amp; greet) $100.00 + S/C /<br /><br />GA Advance tickets $35.00 + S/C available online at Ticketfly.com, UnionEvents.com, Rotate This, Soundscapes</div>",
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

  it "should extract ticket sales URL from description string" do
    le = Lastfm::Event.new(sample)
    le.tickets_url.should == "http://ticketf.ly/11UbDtS" #prefer URL that has word 'ticket' in it
  end
end
