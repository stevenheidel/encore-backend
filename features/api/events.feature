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
        "image_url": "TODO: default image for events without images",
        "venue_name": "Venue name",
        "venue": {
          "street": "Street Name",
          "city": "City Name",
          "postalcode" : "Postal Code",
          "country" : "Country Name",
          "coordinates": "1234, 1234"
        },
        "headliner": "Artist Name",
        "artists": {
          "artist": "Artist Name"
        }
        
      }
      """

  Scenario: Today List
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
        "image_url": "TODO: default image for events without images",
        "venue_name": "Venue name",
        "venue": {
          "street": "Street Name",
          "city": "City Name",
          "postalcode" : "Postal Code",
          "country" : "Country Name",
          "coordinates": "1234, 1234"
        },
        "headliner": "Artist Name",
        "artists": {
          "artist": "Artist Name"
        }
        
      }
      """

  @vcr
  Scenario: Future List
    When I send a GET request to "/api/v1/events/future.json" with the following:
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
        "image_url": "TODO: default image for events without images",
        "venue_name": "Venue name",
        "venue": {
          "street": "Street Name",
          "city": "City Name",
          "postalcode" : "Postal Code",
          "country" : "Country Name",
          "coordinates": "1234, 1234"
        },
        "headliner": "Artist Name",
        "artists": {
          "artist": "Artist Name"
        }
        
      }
      """