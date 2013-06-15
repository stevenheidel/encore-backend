$(document).ready ->
  # Create the menu
  $.getJSON "/api/v1/users/" + $("#container").attr('data-id') + "/concerts.json", (concerts) ->
    # TODO sort between future and past
    $("#menu").html ich.menu_template concerts

    # Deal with navigation
    $("#menu a").click ->
      $("#menu li.current").removeClass('current')
      $(this).parent().addClass('current')
      switch $(this).attr('id')
        when "past"
          insert_past()
        when "today"
          insert_today()
        when "future"
          insert_future()
        else
          insert_concert($(this).attr('id'))

insert_past = ->
  $("#content").html "past"

insert_today = ->
  $("#content").html "today"

insert_future = ->
  $("#content").html "future"

insert_concert = (id) ->
  $.getJSON "/api/v1/concerts/" + id + ".json", (concert) ->
    $("#content").html ich.concert_template concert

    # Load posts on click
    $("#photos a").click ->
      $.getJSON "/api/v1/concerts/" + concert.concert.server_id + "/posts.json", (posts) ->
        $("#photos").html ich.posts_template posts