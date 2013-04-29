tabeaize = (link, links, targets) ->
  links.not(link).removeClass('active')
  target = $(link.addClass('active').attr('href'))
  targets.not(target.show()).hide()

@init_tabs = () ->
  links = $('.tabs a')
  targets = $('.tabs_target')
  tabeaize(links.closest('.active'), links, targets)
  links.on 'click', ->
    tabeaize($(this), links, targets)
    false
