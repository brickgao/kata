# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
render_unread_messages_count = (count) ->
  $('li#messages-menu-item').children(':first').append "(#{count.unread_messages_count})"

$ ->
  $.get '/messages/count', '', render_unread_messages_count, 'json'
