myPosition = new Array
$ ->
  check_box = $("#spot_use_address")
  div_address = $("#div_address")
  latitude = $("#spot_latitude")
  longitude = $("#spot_longitude")
  if check_box.prop('checked')
    longitude.attr('disabled', true)
    latitude.attr('disabled', true)
  else
    div_address.hide()
    getLocation()
  check_box.change ->
    if $(this).prop("checked")
      div_address.show()
      longitude.attr('disabled', true)
      latitude.attr('disabled', true)
    else
      div_address.hide()
      getLocation()
      longitude.removeAttr('disabled')
      latitude.removeAttr('disabled')

onSuccess = (position) ->
  myPosition[0] = position.coords.latitude
  myPosition[1] = position.coords.longitude
  $("#spot_latitude").val(myPosition[0])
  $("#spot_longitude").val(myPosition[1])
  return

onError = (err) ->
  message = undefined
  switch err.code
    when 0
      message = 'Unknown error: ' + err.message
    when 1
      message = 'You denied permission to retrieve a position.'
    when 2
      message = 'The browser was unable to determine a position: ' + error.message
    when 3
      message = 'The browser timed out before retrieving the position.'
  return

getLocation = ->
  navigator.geolocation.getCurrentPosition onSuccess, onError,
    enableHighAccuracy: true
    timeout: 20000
    maximumAge: 120000
  return
