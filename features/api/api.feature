@vcr
Feature: API
  In order to communicate with the server
  As an iPhone app user
  I want to use an internal API
  
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
  Then the JSON response should have "response" with the text "success"

Scenario: List of User's Concerts (with events)
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
            "venue_name": "Venue name"
          }
        ],
        "future": [
          {
            "lastfm_id": "12345",
            "name": "Event Name",
            "venue_name": "Venue name"
          }
        ]
      }
    }
    """

@wip
Scenario: Today List
  When I send a GET request to "/api/v1/events/today.json"
  Then the JSON response should be:

@wip
Scenario: Future List
  When I send a GET request to "/api/v1/events/future.json"
  Then the JSON response should be:

Scenario: Search for an Artist's Events
  When I send and accept JSON
  And I send a GET request to "/api/v1/artists/search.json" with the following:
    """
    {
      "city": "Toronto",
      "term": "Cher",
      "tense": "past"
    }
    """
  Then the JSON response should have "$.artists[0].name" with the text "Cher"
  # TODO: implement version wherein you can have multiline strings as a with the text
  And the JSON response should have "$.artists..name" with a length of 30

Scenario: Check if Event on Profile
  Given there is a user (with events) with the facebook_id "696955405"
  And I send and accept JSON
  # TODO should be the default
  And I send a GET request to "/api/v1/users/696955405/events.json" with the following:
    """
    {
      "lastfm_id": 12345
    }
    """
  Then the JSON response should have "response" with the text "true"