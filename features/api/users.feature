Feature: Users API

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

  @wip
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

  Scenario: Check if Event on Profile
    Given there is a user (with events) with the facebook_id "696955405"
    When I send a GET request to "/api/v1/users/696955405/events.json" with the following:
      """
      {
        "lastfm_id": 54321
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
    When I send a DELETE request to "/api/v1/users/696955405/events/54321.json"
    Then the JSON response should have "response" with the text "success"
    # TODO: check if the event was removed from the user