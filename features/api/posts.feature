Feature: Posts API

  Background:
    Given I send and accept JSON

  @wip
  Scenario: Viewing all Posts
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

  Scenario: Flag a Post
    Given there is a post with the _id "51e6dafd05ac8299110147fc"
    When I send a POST request to "/api/v1/posts/51e6dafd05ac8299110147fc/flag.json" with the following:
      """
      {
        "type": "Not relevant",
        "facebook_id": 696955405
      }
      """
    Then the JSON response should have "response" with the text "success"