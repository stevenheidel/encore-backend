# == Schema Information
#
# Table name: events
#
#  id               :uuid             not null, primary key
#  lastfm_id        :string(255)
#  name             :string(255)
#  website          :text
#  url              :string(255)
#  flickr_tag       :string(255)
#  headliner        :string(255)
#  start_date       :datetime
#  local_start_time :datetime
#  tickets_url      :text
#  venue_id         :uuid
#  created_at       :datetime
#  updated_at       :datetime
#  sidekiq_workers  :text
#  users_count      :integer          default(0)
#  image_url_cached :string(255)
#

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

  describe "extract_tickets_url" do
    it "should extract ticket sales URL from description string" do
      le = Lastfm::Event.new(sample)
      le.tickets_url.should == "http://ticketf.ly/11UbDtS" #prefer URL that has word 'ticket' in it

      le = Lastfm::Event.new({"website"=>"http://www.ticketweb.ca/t3/sale/SaleEventDetail?dispatch=loadSelectionData&eventId=3792124"})
      le.tickets_url.should == "http://www.ticketweb.ca/t3/sale/SaleEventDetail?dispatch=loadSelectionData&eventId=3792124" #prefer URL that has word 'ticket' in it
      
      le = Lastfm::Event.new({"tickets"=>"http://www.ticketweb.ca/t3/sale/SaleEventDetail?dispatch=loadSelectionData&eventId=3792124"})
      le.tickets_url.should == "http://www.ticketweb.ca/t3/sale/SaleEventDetail?dispatch=loadSelectionData&eventId=3792124" #prefer URL that has word 'ticket' in it
    end

    it "should fail gracefully" do
      le = Lastfm::Event.new({"description"=>nil})
      le.tickets_url.should == nil

      le = Lastfm::Event.new({"description"=>""})
      le.tickets_url.should == nil

      le = Lastfm::Event.new({"startDate"=>"Fri, 12 Jul 1963 18:00:00"})
      le.tickets_url.should == nil

      le = Lastfm::Event.new({"description"=>"<div class=\"bbcode\">General Admission<br />$15.00<br /><br />19+</div>"})
      le.tickets_url.should == nil

      le = Lastfm::Event.new({"description"=>15.00})
      le.tickets_url.should == nil

      le = Lastfm::Event.new("{startDate: Fri, 12 Jul 1963 18:00:00}")
      le.tickets_url.should == nil

      le = Lastfm::Event.new({1=> "some", 2=> "some", 3=> "some"})
      le.tickets_url.should == nil
      le = Lastfm::Event.new([1,2,3])
      le.tickets_url.should == nil
    end

    it "should work for the samples" do
      def check(id)
        Lastfm::Event.new(LastfmAPI.event_getInfo(id)).tickets_url
      end

      # See examples here: https://github.com/stevenheidel/encore-backend/issues/65
      check(3751082).should == "http://www.ticketmaster.ca/event/10004B82B64C638D"
      check(3761369).should == "http://www.wavelengthtoronto.com/wavelog/2013/12/wavelength-music-festival-fourteen"
      check(3650152).should == "http://www.ticketmaster.ca/event/10004AC4F02EA4AA"
      check(3788977).should == "http://adelaidehallto.com/event/sam-roberts-band/"
      check(3758642).should == "http://www.collectiveconcerts.com/event/446067-robert-ellis-toronto/"
      check(3770209).should == "http://www.last.fm/event/3770209+Paint+at+Rancho+Relaxo+on+14+February+2014"
      check(3757290).should == "http://www.generalmotorscentre.com/"
      check(3742671).should == "https://www.facebook.com/events/581540511899588/"
      check(3775584).should == "https://www.facebook.com/events/1443349222545554/"
      check(3776610).should == "https://www.facebook.com/events/494672223984264/"
      check(3755601).should == "http://www.generalmotorscentre.com/"
      check(3805464).should == "https://www.facebook.com/events/192760027601312/"
      check(3656109).should == "http://www.markham.ca/Markham/Attractions/Theatre/"
    end
  end
end
