$.fn.get_params = () ->
  params = {}
  $(this).children('select').each (index, item) ->
    params[$(item).attr('name')] = $(item).val()

  params['semester_id'] = $(this).closest('form').find('#stream_semester_id').val()
  params

remove_handler = () ->
  $('.remove_link').not('.charged').addClass('charged').on 'click', ->
    $(this).closest('li').remove()
    false

change_handler = (url) ->
  $('.education_item').not('.charged').addClass('charged').children('select:not(:last)').on 'change', ->
    target = $(this).closest('li')
    $.ajax(
      url: url
      data: target.get_params()
    ).done (data) ->
      target.replaceWith(data)
      change_handler(url)
      remove_handler()

@init_streams = () ->
  form     = $('.stream_form')
  new_link = $('.new_link', form)
  list     = $('ul', form)
  url      = new_link.attr('href')

  change_handler(url)
  remove_handler()

  new_link.on 'click', ->
    $.ajax(
      url: url
      data: {}
    ).done (data) ->
      list.append(data)
      change_handler(url)
      remove_handler()

    false
