params = {}
inputIndexID = 0

init = ->
  params['discipline'] = $('#performance_discipline option:first').attr('value')
  $('a[data-add="athlete"]').data('params', params)

clearAthletes = ->
  # remove all athletes... not nice, but quick solution
  $('.athletes_performances').empty()

cloneMe = (element) ->
  eleclone = element.clone(true)
  inputIndexID++
  for input in eleclone.find('input')
     inputID = $(input).attr('id')
     inputName = $(input).attr('name')
     $(input).attr('id', inputID.replace(/[0-9]+/, inputIndexID))
     $(input).attr('name', inputName.replace(/[0-9]+/,inputIndexID))
     $(eleclone).find('input[id="' + inputID + '"]').replaceWith($(input))
  $(element).after(eleclone)

$ ->
  init()
  
  $('a[data-remove="all_athletes"]').click (event) ->
    event.preventDefault()
    clearAthletes()
    
  $('#performance_discipline').change ->
    params['discipline'] = this.value
    clearAthletes()
    
  $(document).on 'click', 'a[data-remove="athlete"]', (event) ->   
    event.preventDefault()
    $(this).parent().remove()
    
  $('a[data-add="athlete"]').click ->
    if $('.athletes_performances').children().length > 0
      cloneMe($('.athletes_performances').children().last())
      return false
  
  $('a[data-add="athlete"]').on 'ajax:before', ->
    $(this).data('params', params)
    
