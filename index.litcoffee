Encore API
==========

Welcome
-------

**Login with Facebook**

    POST '/users'

    Request:
    {
      "expiration_date": "2013-08-02T02:53:23Z",
      "oauth": "CAACp5xj4c9sBAIeNLxb3204nzPOYmP......",
      "facebook_id": 12345,
      "name": "Steven Heidel"
    }

    Response:
    {
      "response": "success"
    }

**List of User's Concerts**

- should return image_url with each concert

    GET '/users/:facebook_id/concerts'

    Response:
    {
      "concerts": {
        "past": [@concerts],
        "future": [@concerts]
      }
    }

Concert Listings
----------------

**Today List**

- should be populated daily for Toronto in the morning

    GET '/concerts/today'

    Request:
    {
      "city": "Toronto"
    }

    Response:
    {
      "concerts": [@concerts]
    }

**Future List**

- should work for multiple cities
- should be based on latitude and longitude

    GET '/concerts/future'

    Request:
    {
      "city": "Toronto"
    }

    Response:
    {
      "concerts": [@concerts]
    }

Searching
---------

**Search for an Artist's Concerts**

- should be implemented based on this spec

    GET '/artists/search'

    Request:
    {
      "city": "Toronto",
      "term": "Radiohe",
      "tense": "past" / "future"
    }

    Response:
    {
      "artist": @artist,
      "others": [@artists]
      "concerts": [@concerts]
    }

**Artist's Past Concerts**

    GET '/artists/:songkick_id/concerts/past'

    Request:
    {
      "city": "Toronto"
    }

    Response:

    {
      "concerts": [@concerts]
    }

**Artist's Future Concerts**

    GET '/artists/:songkick_id/concerts/future'

    Request:
    {
      "city": "Toronto"
    }

    Response:

    {
      "concerts": [@concerts]
    }

Viewing Concerts
----------------

**Check if Concert on Profile**

    GET '/users/:facebook_id/concerts'

    Request:
    {
      "songkick_id": 12345
    }

    Response:
    {
      "response": true / false
    }

**Add Concert to Profile**

    POST '/users/:facebook_id/concerts'

    Request:
    {
      "songkick_id": 12345
    }

    Response:
    {
      "response": "success"
    }

**Remove Concert from Profile**

    DELETE '/users/:facebook_id/concerts/:songkick_id'

    Response:
    {
      "response": "success"
    }

**Viewing all Photos**

    GET '/concerts/:songkick_id/posts'

    Response:
    {
      "posts": [@posts]
    }

**Upload Photos**

- should attach post to User

    POST '/concerts/:songkick_id/posts'

    Request:
    {
      "facebook_id": 1651770074,
      "image": MultiPart::File
    }

Entities
--------

**@artist**

- should return image_url

    {
      "name": "Radiohead",
      "songkick_id": 12345,
      "image_url": "http:\/\/www1.sk-static.com\/images\/media\/profile_images\/artists\/16151999\/avatar"
    }

**@concert**

- start time is sometimes null

    {
      "songkick_id": 16151999,
      "name": "Logic",
      "date": "2013-06-26",
      "start_time": "19:00:00",
      "venue_name": "Virgin Mobile Mod Club",
      "image_url": "http:\/\/www1.sk-static.com\/images\/media\/profile_images\/artists\/16151999\/avatar"
    }

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