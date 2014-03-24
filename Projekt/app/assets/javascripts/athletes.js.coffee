# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

inputElement = 'input[name^="organization_units"]'
numberOfOrgaUnits = 5

####
# function inserts input fields to add some
# organization_units
add_orga_unit = (event) ->
  event.preventDefault()
  if $(inputElement).is(':hidden')
    toggle_first_field()
  else
    newForm = $('div.field:last').clone(true)
    inputNo = $(document).find(inputElement).length
    nameToSet = 'organization_units['.concat(inputNo).concat(']')
    idToSet = 'organization_units_'.concat(inputNo)
    newForm.find(inputElement).val('').attr('id', idToSet).attr('name', nameToSet)
    $('div.field:last').after( newForm ) if inputNo < numberOfOrgaUnits
    

remove_orga_unit = (event) ->
  event.preventDefault()
  inputNo = $(document).find(inputElement).length
  if $(document).find(inputElement).length == 1
    toggle_first_field()
  else
    $(this).parent().parent().remove()
    
toggle_first_field = ->
  $lastField = $(inputElement).parent()
  $lastField.toggle()

toggle_phone_number = ->
  $('input#athlete_phone').toggle()
  

$ ->
  $('form#new_athlete').ready toggle_first_field
  $('a#add_orga_unit').click add_orga_unit
  $('a.del_orga_unit').click remove_orga_unit
  
  $(document).on 'click', 'a[data-edit="abort"]', (event) ->
    $('.edit_user').replaceWith(oldData)
    return false