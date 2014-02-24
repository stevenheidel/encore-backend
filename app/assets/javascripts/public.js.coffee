#= require jquery.inview.min.js

$ ->
  $('a.load-more-posts').on 'inview', (e, visible) ->
    return unless visible
    
    $.getScript $(this).attr('href')

WebFontConfig = fontdeck:
  id: "34568"

(->
  wf = document.createElement("script")
  wf.src = ((if "https:" is document.location.protocol then "https" else "http")) + "://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js"
  wf.type = "text/javascript"
  wf.async = "true"
  s = document.getElementsByTagName("script")[0]
  s.parentNode.insertBefore wf, s
)()

((i, s, o, g, r, a, m) ->
  i["GoogleAnalyticsObject"] = r
  i[r] = i[r] or ->
    (i[r].q = i[r].q or []).push arguments_

  i[r].l = 1 * new Date()

  a = s.createElement(o)
  m = s.getElementsByTagName(o)[0]

  a.async = 1
  a.src = g
  m.parentNode.insertBefore a, m
) window, document, "script", "//www.google-analytics.com/analytics.js", "ga"
ga "create", "UA-40542837-4", "encore.fm"
ga "send", "pageview"