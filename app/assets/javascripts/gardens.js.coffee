# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

mouse_is_down = false


$(document).mousedown (event) ->
  $('.garden-table .cell').removeClass('active')
  $('#garden-controls').fadeOut()
  mouse_is_down = false
  true


$('#garden-editor').mousedown (event) ->
  event.stopPropagation()
  mouse_is_down = true


$('#garden-editor').mouseup (event) ->
  mouse_is_down = false

  if $('.garden-table .cell.active').size() > 0
    $('#garden-controls').fadeIn()


$('.garden-table').mousemove (event) ->
  if mouse_is_down
    $(event.target).closest('.cell').addClass('active')


$('.garden-table .cell').mousedown (event) ->
  $(this).toggleClass('active')

  if $('.garden-table .cell.active').size() == 0
    $('#garden-controls').fadeOut()

$('#harvest').click (event) ->
  event.preventDefault()
  event.stopPropagation()

  coords  = []
  url     = Routes.bulk_harvest_garden_path(id: window.garden_id)

  $('.garden-table .cell.active').each (index, element) ->
    point = [$(element).prop('cellIndex') + 1, $(element).closest('tr').prop('rowIndex') + 1]
    coords.push(point)

  $('#garden-controls').fadeOut()

  $.ajax url,
    type: 'POST'
    data: {coords: coords}
    error: (data) ->
      response_object = data.responseJSON
      alert response_object.message
    success: (data) ->
      $('.garden-table .cell.active').html('-')
      $('.garden-table .cell').removeClass('active')


$('#plant').change (event) ->
  coords  = []
  value   = $(this).val()
  label   = $("option[value=#{value}]").html()
  url     = Routes.bulk_add_garden_path(id: window.garden_id)

  $('.garden-table .cell.active').each (index, element) ->
    point = [$(element).prop('cellIndex') + 1, $(element).closest('tr').prop('rowIndex') + 1]
    coords.push(point)

  $('#plant').val('') # reset plant picker
  $('#garden-controls').fadeOut()

  $.ajax url,
    type: 'POST'
    data: {plant_id: value, coords: coords}
    error: (data) ->
      response_object = data.responseJSON
      alert response_object.message
    success: (data) ->
      $('.garden-table .cell.active').html(label)
      $('.garden-table .cell').removeClass('active')