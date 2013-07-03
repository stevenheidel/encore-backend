Encore API v1
=============

_All URLs begin with 'http://{server}/api/v1' and end with '.json'_

**Welcome**
-----------

**Login with Facebook**

    POST '/users'

    Request:
    {
      "expiration_date": "2013-08-02T02:53:23Z",
      "oauth": "CAACp5xj4c9sBAIeNLxb3204nzPOYmP......",
      "facebook_id": 696955405,
      "name": "Steven Heidel"
    }

    Response:
    {
      "response": "success"
    }

**List of User's Events**

- should return image_url with each event

    GET '/users/:facebook_id/events'

    Response:
    {
      "events": {
        "past": [@past_event],
        "future": [@future_event]
      }
    }

**Event Listings**
--------------------

**Today List**

- should be populated daily for Toronto in the morning

    GET '/events/today'

    Request:
    {
      "city": "Toronto"
    }

    Response:
    {
      "events": [@event]
    }

**Future List**

- should work for multiple cities
- should be based on latitude and longitude

    GET '/events/future'

    Request:
    {
      "city": "Toronto"
    }

    Response:
    {
      "events": [@event]
    }

**Searching**
-------------

**Search for an Artist's Events**

- should be implemented based on this spec
- tense can be either "past" or "future"

    GET '/artists/search'

    Request:
    {
      "city": "Toronto",
      "term": "Cher",
      "tense": "past"
    }

    Response:
    {
      "artist": @artist,
      "others": [@artist],
      "events": [@event]
    }

**Artist's Past Events**

    GET '/artists/:lastfm_id/events/past'

    Request:
    {
      "city": "Toronto"
    }

    Response:

    {
      "events": [@event]
    }

**Artist's Future Events**

    GET '/artists/:lastfm_id/events/future'

    Request:
    {
      "city": "Toronto"
    }

    Response:

    {
      "events": [@event]
    }

**Viewing Events**
--------------------

**Check if Event on Profile**

    GET '/users/:facebook_id/events'

    Request:
    {
      "lastfm_id": 12345
    }

    Response:
    {
      "response": true
    }

**Add Event to Profile**

    POST '/users/:facebook_id/events'

    Request:
    {
      "lastfm_id": 12345
    }

    Response:
    {
      "response": "success"
    }

**Remove Event from Profile**

    DELETE '/users/:facebook_id/events/:lastfm_id'

    Response:
    {
      "response": "success"
    }

**Viewing all Photos**

    GET '/events/:lastfm_id/posts'

    Response:
    {
      "posts": [@post]
    }

**Upload Photos**

- should attach post to User

    POST '/events/:lastfm_id/posts'

    Request:
    {
      "facebook_id": 1651770074,
      "image": @file
    }

**Entities**
------------

**@artist**

- should return image_url

    {
      "name": "Radiohead",
      "lastfm_id": 12345,
      "image_url": "http:\/\/www1.sk-static.com\/images\/media\/profile_images\/artists\/16151999\/avatar"
    }

**@event**

- start time is sometimes null

    {}

**@past_event**

    {
      "lastfm_id": 1196301,
      "name": "pRIvate",
      "date": "2009-08-28",
      "venue_name": "Berlusconni´s",
      "image_url": ""
    }

**@future_event**

    {
      "lastfm_id": 3591559,
      "name": "Spiders",
      "date": "2013-07-03",
      "venue_name": "Wurlitzer Ballroom",
      "image_url": ""
    }

**@file**

    {}

**@post**

    {
      "instagram_uuid": "472701103535947622_280348198",
      "caption": "Mick Jagger",
      "link": "http:\/\/instagram.com\/p\/aPXyYxMf9m\/",
      "image_url": "http:\/\/distilleryimage2.s3.amazonaws.com\/ec8a077ccf1511e2ae4022000ae911aa_7.jpg",
      "user_name": "josephjbrant",
      "user_profile_picture": "http:\/\/images.ak.instagram.com\/profiles\/profile_280348198_75sq_1357094536.jpg",
      "user_uuid": "280348198"
    }