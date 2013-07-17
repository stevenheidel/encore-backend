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
    And the JSON response should have the following under "artist":
      """
      {
        "name": "The Rolling Stones",
        "lastfm_id": "The Rolling Stones",
        "image_url": "http://userserve-ak.last.fm/serve/_/7596573/The+Rolling+Stones+rolling+stones+malmo.jpg"
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
        "image_url": "TODO: default image for events without images",
        "venue_name": "Venue name"
      }
      """

  Scenario: List of artist's past events
    When I send a GET request to "/api/v1/artists/Vampire%20Weekend/events/past.json" with the following:
      """
      {
        "latitude": 43.670906,
        "longitude": -79.393331
      }
      """
    Then the JSON response should have 6 copies similar to this under "events":
      """
      {
        "lastfm_id": "12345",
        "name": "Event Name",
        "date": "2014-08-28",
        "image_url": "TODO: default image for events without images",
        "venue_name": "Venue name"
      }
      """

  Scenario: List of artist's future events
    When I send a GET request to "/api/v1/artists/Imagine%20Dragons/events/future.json" with the following:
      """
      {
        "latitude": 43.670906,
        "longitude": -79.393331
      }
      """
    Then the JSON response should have 1 copies similar to this under "events":
      """
      {
        "lastfm_id": "12345",
        "name": "Event Name",
        "date": "2014-08-28",
        "image_url": "TODO: default image for events without images",
        "venue_name": "Venue name"
      }
      """