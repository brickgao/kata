# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
render_nodes = (nodes) ->
  $('select#post_node').append $('<option>', { value: node.id, text: node.name }) for node in nodes

$ ->
  $.get '/nodes', '', render_nodes, 'json'
