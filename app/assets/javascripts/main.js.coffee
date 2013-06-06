$ ->
  init_collapser()  if $('.collapser').length
  init_datepicker() if $('.datepicker').length
  init_tabs()       if $('.tabs').length
  init_streams()    if $('.stream_form').length
  init_boolean_handler() if $('.rpz_info table').length
  init_counter()    if $('.current_total').length
  init_copy()       if $('.copy_link').length
