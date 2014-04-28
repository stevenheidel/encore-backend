Feature: Events API

  Background:
    Given I send and accept JSON

  Scenario: Past List
    When I send a GET request to "/api/v1/events/past.json" with the following:
      """
      {
        "latitude": 43.670906,
        "longitude": -79.393331,
        "radius": 0.5
      }
      """
    # TODO: nothing will be in the database because Sidekiq hasn't run
    Then the JSON response should have 0 copies similar to this under "events":
      """
      {
        "lastfm_id": "12345",
        "name": "Event Name",
        "date": "2014-08-28",
        "start_time": "Tue, 23 Jul 2013 19:00:00 +0000",
        "image_url": "TODO: default image for events without images",
        "lastfm_url": "http://www.last.fm/event/1559988+Justin+Bieber+at+Air+Canada+Centre+on+23+November+2010",
        "tickets_url": "http://www.ticketweb.ca/t3/sale/SaleEventDetail?dispatch=loadSelectionData&amp;eventId=3602664&amp;pl=embrace",
        "venue_name": "Venue name",
        "venue": {
          "street": "Street Name",
          "city": "City Name",
          "postalcode": "Postal Code",
          "country": "Country Name",
          "latitude": 43.643929,
          "longitude": -79.379305
        },
        "headliner": "Artist Name",
        "artists": [
          {"artist": "Artist Name"}
        ]
      }
      """

  @vcr_record_once
  Scenario: Today List
    Given the time is Jan 29 2014, 15:00 UTC
    When I send a GET request to "/api/v1/events/today.json" with the following:
      """
      {
        "latitude": 43.670906,
        "longitude": -79.393331,
        "radius": 0.5
      }
      """
    Then the JSON response should have more than 2 copies similar to this under "events":
      """
      {
        "lastfm_id": "12345",
        "name": "Event Name",
        "date": "2014-08-28",
        "start_time": "Tue, 23 Jul 2013 19:00:00",
        "image_url": "TODO: default image for events without images",
        "lastfm_url": "http://www.last.fm/event/1559988+Justin+Bieber+at+Air+Canada+Centre+on+23+November+2010",
        "tickets_url": "http://www.ticketweb.ca/t3/sale/SaleEventDetail?dispatch=loadSelectionData&amp;eventId=3602664&amp;pl=embrace",
        "venue_name": "Venue name",
        "venue": {
          "street": "Street Name",
          "city": "City Name",
          "postalcode": "Postal Code",
          "country": "Country Name",
          "latitude": 43.643929,
          "longitude": -79.379305
        },
        "headliner": "Artist Name",
        "artists": [
          {"artist": "Artist Name"}
        ]
      }
      """

  @wip
  Scenario: Future List
    When I send a GET request to "/api/v1/events/future.json" with the following:
      """
      {
        "latitude": 43.670906,
        "longitude": -79.393331,
        "radius": 0.5,
        "page": 1,
        "limit": 50
      }
      """
    Then the JSON response should have something similar to the following under "$":
      """
        {
          "total": 573,
          "events": "null"
        }
      """
    And the JSON response should have more than 2 copies similar to this under "events":
      """
      {
        "lastfm_id": "12345",
        "name": "Event Name",
        "date": "2014-08-28",
        "start_time": "Tue, 23 Jul 2013 19:00:00",
        "image_url": "TODO: default image for events without images",
        "lastfm_url": "http://www.last.fm/event/1559988+Justin+Bieber+at+Air+Canada+Centre+on+23+November+2010",
        "tickets_url": "http://www.ticketweb.ca/t3/sale/SaleEventDetail?dispatch=loadSelectionData&amp;eventId=3602664&amp;pl=embrace",
        "venue_name": "Venue name",
        "venue": {
          "street": "Street Name",
          "city": "City Name",
          "postalcode": "Postal Code",
          "country": "Country Name",
          "latitude": 43.643929,
          "longitude": -79.379305
        },
        "headliner": "Artist Name",
        "artists": [
          {"artist": "Artist Name"}
        ]
      }
      """

  Scenario: Seatgeek Url
    When I send a GET request to "/api/v1/events/3749717/seatgeek_url.json"
    Then the JSON response should be:
      """
      {
        "seatgeek_url": "http://seatgeek.com/lady-gaga-with-lady-starlight-and-crayon-pop-tickets/toronto-air-canada-centre-2014-07-09-7-30-pm/concert/1916510/?aid=10708"
      }
      """