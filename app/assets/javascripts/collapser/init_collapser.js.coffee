@init_collapser = () ->
  $('.collapser .info a.show').click ->
    link = $(this)
    info = link.closest('.info')
    link.toggleClass('opened').toggleClass('closed')
    $('.details', link.closest('li')).slideToggle('fast')
    false

