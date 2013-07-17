@vcr
Feature: API
  In order to communicate with the server
  As an iPhone app user
  I want to use an internal API

  Background:
    Given I send and accept JSON
    
  Scenario: Login with Facebook
    When I send a POST request to "/api/v1/users.json" with the following:
      """
      {
        "expiration_date": "2013-08-02T02:53:23Z",
        "oauth": "CAACp5xj4c9sBAIeNLxb3204nzPOYmP......",
        "facebook_id": 696955405,
        "name": "Steven Heidel"
      }
      """
    Then the JSON response should be:
      """
      {
        "user": {
          "name": "Steven Heidel",
          "facebook_image_url": "https://graph.facebook.com/696955405/picture?type=large"
        }
      }
      """
    # TODO: add here to check for user

  Scenario: List of User's Events
    Given there is a user (with events) with the facebook_id "696955405"
    When I send a GET request to "/api/v1/users/696955405/events.json"
    Then the JSON response should be:
      """
      {
        "events": {
          "past": [
            {
              "lastfm_id": "54321",
              "name": "Event Name",
              "date": "2009-08-28",
              "image_url": "TODO: default image for events without images",
              "venue_name": "Venue name"
            }
          ],
          "future": [
            {
              "lastfm_id": "12345",
              "name": "Event Name",
              "date": "2014-08-28",
              "image_url": "TODO: default image for events without images",
              "venue_name": "Venue name"
            }
          ]
        }
      }
      """

  Scenario: Today List
    When I send a GET request to "/api/v1/events/today.json" with the following:
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

  Scenario: Future List
    When I send a GET request to "/api/v1/events/future.json" with the following:
      """
      {
        "latitude": 43.670906,
        "longitude": -79.393331
      }
      """
    Then the JSON response should have 30 copies similar to this under "events":
      """
      {
        "lastfm_id": "12345",
        "name": "Event Name",
        "date": "2014-08-28",
        "image_url": "TODO: default image for events without images",
        "venue_name": "Venue name"
      }
      """

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

  Scenario: Check if Event on Profile
    Given there is a user (with events) with the facebook_id "696955405"
    When I send a GET request to "/api/v1/users/696955405/events.json" with the following:
      """
      {
        "lastfm_id": 12345
      }
      """
    Then the JSON response should have "response" with the text "true"

  # TODO: what if the event isn't yet persisted in the database???
  Scenario: Add Event to Profile
    Given there is a user with the facebook_id "696955405"
    When I send a POST request to "/api/v1/users/696955405/events.json" with the following:
      """
      {
        "lastfm_id": "3196544"
      }
      """
      # that's a Madonna concert from 2012
    Then the JSON response should have "response" with the text "success"
    # TODO: check if the event was persisted

  Scenario: Remove Event from Profile
    Given there is a user (with events) with the facebook_id "696955405"
    When I send a DELETE request to "/api/v1/users/696955405/events/12345.json"
    Then the JSON response should have "response" with the text "success"
    # TODO: check if the event was removed from the user

  @wip
  Scenario: Viewing all Photos
    # Given there are photos
    Given there is an event with the lastfm_id 12345
    When I send a GET request to "/api/v1/events/12345/posts.json"
    Then the JSON response should have "$.events" with a length of 0
    # Then there are photos

  @wip
  Scenario: Upload Photos
    Given there is an event with the lastfm_id 12345
    And there is a user (with events) with the facebook_id "696955405"

  Scenario: Checking if Event Population is in Progress
    Given there is an event with the lastfm_id 12345
    When I send a GET request to "/api/v1/events/12345/populating.json"
    Then the JSON response should have "response" with the text "false"