$.fn.count_sum = () ->
  values = $(this).map (index, input) -> parseInt($(input).val()) || 0
  $.makeArray(values).reduce (x,y) -> x + y

$.fn.set_sum = (sum, planned) ->
  $(this).text sum
  if sum > planned
    $(this).addClass('warning')
  else
    $(this).removeClass('warning')

@init_counter = () ->
  $('.current_total').each (index, item) ->
    item = $(item)
    inputs = item.nextAll().find('input')
    planned_total = parseInt(item.prev('.planned_total').text()) || 0
    item.set_sum inputs.count_sum(), planned_total
    inputs.on 'change', ->
      item.set_sum inputs.count_sum(), planned_total
