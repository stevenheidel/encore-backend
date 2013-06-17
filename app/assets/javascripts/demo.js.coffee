# Ajax loader
$(document).ajaxStart ->
    $('body').addClass("loading")
$(document).ajaxStop ->
    $('body').removeClass("loading")

$(document).ready ->
  if $("#container").attr('data-userid')?
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

      # Start screen
      insert_today()

insert_past = ->
  $("#content").html ich.ptf_template {'title': 'Past'}

  $("#artist_search").autocomplete {
    source: '/api/v1/artists/search.json',
    minLength: 2,
    response: (event, ui) ->
      $.each ui.content[0], (index, value) ->
        if value?
          ui.content[index] = {
            'label': value.name, 
            'value': value.name,
            'id': value.server_id
          }
    select: (event, ui) ->
      $.getJSON "/api/v1/artists/" + ui.item.id + "/concerts/past?city=" + $("#city_search").val(), (concerts) ->
        $("#concerts").html ich.concerts_template concerts

        # Add Timecapsule to profile
        $("#concerts button").click ->
          $.post '/api/v1/users/' + $("#container").attr('data-userid') + '/concerts', {
            songkick_id: $(this).attr('id')
          }, (data) ->
            console.log data
  }

insert_today = ->
  $("#content").html ich.ptf_template {'title': 'Today'}

insert_future = ->
  $("#content").html ich.ptf_template {'title': 'Future'}

insert_concert = (id) ->
  $.getJSON "/api/v1/concerts/" + id + ".json", (concert) ->
    $("#content").html ich.concert_template concert

    # Load posts on click
    $("#photos a").click ->
      $.getJSON "/api/v1/concerts/" + concert.server_id + "/posts.json", (posts) ->
        $("#photos").html ich.posts_template posts