$ ->
  check_box = $("#spot_use_address")
  div_address = $("#div_address")
  latitude = $("#spot_latitude")
  longitude = $("#spot_longitude")
  if check_box.prop('checked')
    longitude.attr('disabled', true)
    latitude.attr('disabled', true)
  check_box.change ->
    if $(this).prop("checked")
      div_address.show()
      longitude.attr('disabled', true)
      latitude.attr('disabled', true)
    else
      div_address.hide()
      longitude.removeAttr('disabled')
      latitude.removeAttr('disabled')