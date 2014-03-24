
$ ->
  $('a[data-edit="abort_contact"]').live 'click', (event) ->
    $('.edit_organization_unit').replaceWith(old_data)
    return false
  $('a[data-edit="abort_new_sport_facility"]').live 'click', (event) ->
    $('.new_sport_facility').prev().remove()
    $('.new_sport_facility').remove()
    return false
