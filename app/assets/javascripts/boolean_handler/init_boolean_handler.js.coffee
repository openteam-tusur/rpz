@init_boolean_handler = () ->
  $('.rpz_info table').on 'ajax:success', (evt, response, status, jqXHR) ->
    link = $(evt.target)
    target = link.parent('td').html(jqXHR.responseText)

