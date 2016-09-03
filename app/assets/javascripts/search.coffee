# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
do_search = (e) ->
  window.location = '/search?query=' + $(".search").val() if e.keyCode == 13
  
$ ->
  $(".search").keyup do_search
