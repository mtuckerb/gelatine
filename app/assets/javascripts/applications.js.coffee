$ ->
  flashCallback = ->
    $(".flash-message").fadeOut()
  $(".flash-message").bind 'click', (ev) =>
    $(".flash-message").fadeOut()
  setTimeout flashCallback, 5000