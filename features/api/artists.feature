@vcr
Feature: Artists API

  Background:
    Given I send and accept JSON

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
        "start_time": "2010-11-23T19:00:00-05:00",
        "image_url": "TODO: default image for events without images",
        "lastfm_url": "http://www.last.fm/event/1559988+Justin+Bieber+at+Air+Canada+Centre+on+23+November+2010",
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

  Scenario: List of artist's past events
    When I send a GET request to "/api/v1/artists/Vampire%20Weekend/events/past.json" with the following:
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
        "start_time": "2010-11-23T19:00:00-05:00",
        "image_url": "TODO: default image for events without images",
        "lastfm_url": "http://www.last.fm/event/1559988+Justin+Bieber+at+Air+Canada+Centre+on+23+November+2010",
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

  Scenario: List of artist's future events
    When I send a GET request to "/api/v1/artists/Imagine%20Dragons/events/future.json" with the following:
      """
      {
        "latitude": 43.670906,
        "longitude": -79.393331,
        "radius": 0.5
      }
      """
    Then the JSON response should have 1 copies similar to this under "events":
      """
      {
        "lastfm_id": "12345",
        "name": "Event Name",
        "date": "2014-08-28",
        "start_time": "Tue, 23 Jul 2013 19:00:00",
        "image_url": "TODO: default image for events without images",
        "lastfm_url": "http://www.last.fm/event/1559988+Justin+Bieber+at+Air+Canada+Centre+on+23+November+2010",
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