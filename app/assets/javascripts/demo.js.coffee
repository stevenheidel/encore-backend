# Ajax loader
$(document).ajaxStart ->
    $('body').addClass("loading")
$(document).ajaxStop ->
    $('body').removeClass("loading")

$(document).ready ->
  if $("#container").attr('data-userid')?
    insert_menu()

    # Start screen
    insert_today()

insert_menu = ->
  # Create the menu
  $.getJSON "/api/v1/users/" + $("#container").attr('data-userid') + "/concerts.json", (concerts) ->
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

# tense is past, today, or future
enable_search = (tense) ->
  $("#artist_search").autocomplete {
    source: '/api/v1/artists/search.json'
    minLength: 2
    response: (event, ui) ->
      $.each ui.content[0], (index, value) ->
        if value?
          ui.content[index] = {
            'label': value.name, 
            'value': value.name,
            'id': value.songkick_id
          }
    select: (event, ui) ->
      $.getJSON "/api/v1/artists/" + ui.item.id + "/concerts/" + tense + "?city=" + $("#city_search").val(), (concerts) ->
        $("#concerts").html ich.concerts_template concerts
        enable_add()
  }

enable_add = ->
  # Add Timecapsule to profile
  $("#concerts button").click ->
    $.post '/api/v1/users/' + $("#container").attr('data-userid') + '/concerts', {
      songkick_id: $(this).attr('id')
    }, (data) ->
      insert_menu()

insert_popular = (tense) ->
  $.getJSON "/api/v1/concerts/" + tense + "?city=" + $("#city_search").val(), (concerts) ->
    $("#concerts").html ich.concerts_template concerts
    enable_add()

insert_past = ->
  $("#content").html ich.ptf_template {'title': 'Past', 'search': true}
  enable_search("past")

insert_today = ->
  $("#content").html ich.ptf_template {'title': 'Today'}
  insert_popular("today")

insert_future = ->
  $("#content").html ich.ptf_template {'title': 'Future', 'search': true}
  enable_search("future")
  insert_popular("future")

insert_concert = (id) ->
  $.getJSON "/api/v1/concerts/" + id + ".json", (concert) ->
    $("#content").html ich.concert_template concert

    # Remove concert from profile
    $("a#remove").click ->
      $.ajax {
        url: "/api/v1/users/" + $("#container").attr('data-userid') + "/concerts/" + id
        type: 'DELETE'
        success: (result) ->
          insert_menu()
          insert_today()
      }

    # Load posts on click
    $("#photos a").click ->
      $.getJSON "/api/v1/concerts/" + concert.songkick_id + "/posts.json", (posts) ->
        $("#photos").html ich.posts_template posts