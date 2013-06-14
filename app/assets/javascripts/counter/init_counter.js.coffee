$.fn.set_sum = (sum, planned) ->
  $(this).text sum
  if sum > planned
    $(this).addClass('warning')
  else
    $(this).removeClass('warning')

$.fn.count_total = () ->
  this.children('.current_total').set_sum(this.children('.week_cel').get_total(), parseInt(this.children('.planned_total').text()) || 0)

$.fn.count_total_by_week = () ->
  td_class = this.attr('class').match(/weeknumber_\d+/)[0]
  $('tfoot .'+td_class).text($('tbody .'+td_class).get_total())
  $('tfoot tr').count_total()

$.fn.get_total = () ->
  sum = 0
  this.each (index, item) ->
    input = $(item).find('input')
    sum += parseInt(if input.length then input.val() else $(item).text()) || 0
  sum

@init_counter = () ->
  $('.current_total').each (index, item) ->
    $(item).closest('tr').count_total()
  $('form').on 'change', (evt) ->
    row = $(evt.target).closest('tr')
    row.count_total()
    $(evt.target).closest('td').count_total_by_week()
