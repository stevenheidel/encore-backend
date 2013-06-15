$(document).ready ->
  # Create the menu
  $.getJSON "/api/v1/users/1651770074/concerts.json", (concerts)->
    $("#menu").append ich.menu_template concerts

    # Deal with navigation
    $("#menu a").click ->
      $.getJSON "/api/v1/concerts/" + $(this).attr('id') + ".json", (concert)->
        $("#content").append concert.concert.name