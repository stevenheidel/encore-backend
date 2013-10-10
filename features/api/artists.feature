Feature: Artists API

  Background:
    Given I send and accept JSON

  @vcr
  Scenario: Search for an Artist
    When I send a GET request to "/api/v1/artists/search.json" with the following:
      """
      {
        "term": "Cher"
      }
      """
    Then the JSON response should have 30 copies similar to this under "artists":
      """
      {
        "name": "Cher",
        "lastfm_id": "Cher"
      }
      """

  @vcr
  Scenario: Combined Search for an Artist's Events
    When I send a GET request to "/api/v1/artists/combined_search.json" with the following:
      """
      {
        "latitude": 43.670906,
        "longitude": -79.393331,
        "radius": 0.5,
        "term": "The Rolling Stones",
        "tense": "past"
      }
      """
    Then the JSON response should have something similar to the following under "$":
      """
      {
        "artist": "Hash of most likely matching artist",
        "others": "Array of other matching artists",
        "events": "Array of most likely matching artist's events"
      }
      """
    And the JSON response should have something similar to the following under "artist":
      """
      {
        "name": "The Rolling Stones",
        "lastfm_id": "The Rolling Stones",
        "image_url": "http://userserve-ak.last.fm/serve/_/5775770/The+Rolling+Stones+prisonStone.jpg"
      }
      """
    And the JSON response should have 29 copies similar to this under "others":
      """
      {
        "name": "Other",
        "lastfm_id": "Other id"
      }
      """
    And the JSON response should have 6 copies similar to this under "events":
      """
      {
        "lastfm_id": "12345",
        "name": "Event Name",
        "date": "2014-08-28",
        "start_time": "Thu, 22 Aug 2013 20:00:00",
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

  @vcr
  Scenario: Artist Picture
    When I send a GET request to "/api/v1/artists/picture.json?artist_id=Cher"
    Then the JSON response should be:
      """
      {
        "image_url": "http://userserve-ak.last.fm/serve/_/93299741/Cher.png"
      }
      """

  @vcr
  Scenario: List of artist's past events
    When I send a GET request to "/api/v1/events/past.json?artist_id=Vampire%20Weekend" with the following:
      """
      {
        "latitude": 43.670906,
        "longitude": -79.393331,
        "radius": 0.5
      }
      """
    Then the JSON response should have 6 copies similar to this under "events":
      """
      {
        "lastfm_id": "12345",
        "name": "Event Name",
        "date": "2014-08-28",
        "start_time": "Thu, 22 Aug 2013 20:00:00",
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

  @vcr
  Scenario: List of artist's future events
    When I send a GET request to "/api/v1/events/future.json?artist_id=Imagine%20Dragons" with the following:
      """
      {
        "latitude": 53.872715,
        "longitude": -1.372895,
        "radius": 0.5
      }
      """
    Then the JSON response should have 1 copies similar to this under "events":
      """
      {
        "lastfm_id": "12345",
        "name": "Event Name",
        "date": "2014-08-28",
        "start_time": "Thu, 22 Aug 2013 20:00:00",
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
  @vcr
  Scenario: Return Artist info
    When I send a GET request to "/api/v1/artists/info.json?artist_id=Streetlight%20Manifesto&limit_events=2"
    Then the JSON response should be:
      """
        {
        "name": "Streetlight Manifesto",
        "events": {
          "past": [
            {
              "lastfm_id": "3529118",
              "name": "Streetlight Manifesto",
              "date": "2013-07-13",
              "start_time": "Sat, 13 Jul 2013 19:00:00",
              "image_url": "http://userserve-ak.last.fm/serve/252/64020067.jpg",
              "lastfm_url": "http://www.last.fm/event/3529118+Streetlight+Manifesto+at+Lupo%E2%80%99s+Heartbreak+Hotel+on+13+July+2013",
              "tickets_url": null,
              "venue_name": "Lupo’s Heartbreak Hotel",
              "venue": {
                "street": "79 Washington St.",
                "city": "Providence, Rhode Island",
                "postalcode": "02903",
                "country": "United States",
                "latitude": 41.823807,
                "longitude": -71.414551
              },
              "headliner": "Streetlight Manifesto",
              "artists": [
                {
                  "artist": "Streetlight Manifesto"
                },
                {
                  "artist": "Rodeo Ruby Love"
                },
                {
                  "artist": "EMPTY ORCHESTRA"
                }
              ]
            },
            {
              "lastfm_id": "3531564",
              "name": "Streetlight Manifesto",
              "date": "2013-07-12",
              "start_time": "Fri, 12 Jul 2013 20:00:00",
              "image_url": "http://userserve-ak.last.fm/serve/252/64020067.jpg",
              "lastfm_url": "http://www.last.fm/event/3531564+Streetlight+Manifesto",
              "tickets_url": null,
              "venue_name": "The Paramount Theater",
              "venue": {
                "street": "370 New York Ave",
                "city": "Huntington",
                "postalcode": "11743",
                "country": "United States",
                "latitude": 40.869684,
                "longitude": -73.426032
              },
              "headliner": "Streetlight Manifesto",
              "artists": [
                {
                  "artist": "Streetlight Manifesto"
                }
              ]
            }
          ],
          "upcoming": [
            {
              "lastfm_id": "3645343",
              "name": "Streetlight Manifesto",
              "date": "2013-10-10",
              "start_time": "Thu, 10 Oct 2013 21:22:01",
              "image_url": "http://userserve-ak.last.fm/serve/252/64020067.jpg",
              "lastfm_url": "http://www.last.fm/event/3645343+Streetlight+Manifesto+at+House+of+Blues+on+10+October+2013",
              "tickets_url": null,
              "venue_name": "House of Blues",
              "venue": {
                "street": "308 Euclid Avenue",
                "city": "Cleveland",
                "postalcode": "44114",
                "country": "United States",
                "latitude": 41.499724,
                "longitude": -81.690843
              },
              "headliner": "Streetlight Manifesto",
              "artists": [
                {
                  "artist": "Streetlight Manifesto"
                }
              ]
            },
            {
              "lastfm_id": "3653939",
              "name": "Streetlight Manifesto",
              "date": "2013-10-11",
              "start_time": "Fri, 11 Oct 2013 19:00:00",
              "image_url": "http://userserve-ak.last.fm/serve/252/64020067.jpg",
              "lastfm_url": "http://www.last.fm/event/3653939+Streetlight+Manifesto+at+Turner+Hall+Ballroom+on+11+October+2013",
              "tickets_url": null,
              "venue_name": "Turner Hall Ballroom",
              "venue": {
                "street": "1032 N 4th St",
                "city": "Milwaukee",
                "postalcode": "53203",
                "country": "United States",
                "latitude": 43.043781,
                "longitude": -87.915524
              },
              "headliner": "Streetlight Manifesto",
              "artists": [
                {
                  "artist": "Streetlight Manifesto"
                },
                {
                  "artist": "Dan Potthast"
                },
                {
                  "artist": "Mike Park"
                }
              ]
            }
          ]
        }
        }
      """
