@init_copy = () ->
  $('.copy_link').on 'ajax:success', (evt, data) ->
     $('body').append(data)
     box = $('.copy_wrapper')
     box.find('a').on 'click', ->
       box.slideUp ->
         box.remove()
       false
     box.slideDown()

