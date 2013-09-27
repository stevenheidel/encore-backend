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

  Scenario: Update the user
  Given there is a user with the facebook_id "696955405"
  When I send a PATCH request to "/api/v1/users/696955405" with the following:
    """
    {
      "expiration_date": "2013-08-02T02:53:23Z",
      "oauth": "CAACp5xj4c9sBAIeNLxb3204nzPOYmP......",
      "facebook_id": 696955405,
      "name": "Steven Heidel",
      "invite_sent": true,
      "invite_timestamp": "2013-09-27T14:53:23Z"
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

  Scenario: Save a list of facebook friends who attended the Event with User
    Given there is a user (with events) with the facebook_id "696955405"
      And there is a user with the facebook_id "3196544" and invite_sent "true"
    When I send a POST request to "/api/v1/users/696955405/events/54321/add_facebook_friends" with the following:
      """
      {
        "facebook_friend_ids": ["3196544", "123456", "65432196", "951623847"]
      }
      """
    Then the JSON response should be:
      """
        [
          {
            "facebook_id": 3196544,
            "invite_sent": true
          },
          {
            "facebook_id": 123456,
            "invite_sent": false
          },
          {
            "facebook_id": 65432196,
            "invite_sent": false
          },
          {
            "facebook_id": 951623847,
            "invite_sent": false
          }
        ]
      """

  @vcr_record_once
  Scenario: Retrieve a list of facebook friends who attended the Event with User
    Given there is a user (with events) with the facebook_id "696955405"
      And the "Populator::Facebook" job queue is empty
    When I send a POST request to "/api/v1/users/696955405/events/54321/add_facebook_friends" with the following:
      """
      {
        "facebook_friend_ids": ["100003794798865", "515605967", "659574643"]
      }
      """
    And I wait for the worker "Populator::Facebook" to process the job queue
    And I send a GET request to "/api/v1/users/696955405/events/54321/facebook_friends"
    Then the JSON response should be:
      """
        [
          {
            "facebook_id": 100003794798865,
            "name": "Luke Gruber",
            "facebook_image_url": "https://graph.facebook.com/100003794798865/picture?type=large",
            "invite_sent": false
          },
          {
            "facebook_id": 515605967,
            "name": "Nick Trigatti",
            "facebook_image_url": "https://graph.facebook.com/515605967/picture?type=large",
            "invite_sent": false
          },
          {
            "facebook_id": 659574643,
            "name": "Slavik Derevianko",
            "facebook_image_url": "https://graph.facebook.com/659574643/picture?type=large",
            "invite_sent": false
          }
        ]
      """
