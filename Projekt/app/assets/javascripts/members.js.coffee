$ ->    
  $('a[data-remove="members"]').live 'click', (event) ->
    $('.results').fadeOut 'fast', ->
      $(this).empty()
    return false
