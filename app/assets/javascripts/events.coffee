decide = (event, data, status) ->
  $target = $(event.target)
  if data.success
    $target.closest('.event-option-buttons').trigger('ptzcamp:event:update')

changeDecision = () ->
  $this = $(this)
  $this.closest('.event-option-buttons').find('.button-group').removeClass('hide')
  $this.remove()

reloadEvent = (event) ->
  $event = $(event.target)
  $event_list = $event.closest('.event-list')
  if $event_list.length > 0
    $event_list.trigger('ptzcamp:events:update')
  else
    $event.trigger('ptzcamp:event:updated')
    $.ajax("/#{campSlug()}/events/#{$event.data('eventId')}.json",
      success: (data) ->
        replaceHTML($event, data)
    )

reloadEvents = (event) ->
  $events = $(event.target)
  $.ajax("/#{campSlug()}/events.json",
    success: (data) ->
      replaceHTML($events, data)
  )

replaceHTML = ($element, data) ->
  $element.replaceWith(data.html)

campSlug = () ->
  document.location.pathname.split('/')[1]

updateEventParticipants = (event) ->
  $event = $(event.target)
  $.ajax("/#{campSlug()}/events/#{$event.data('eventId')}/participants.json",
    success: (data) ->
      replaceHTML($('.event-participants'), data)
  )

$(document).on('ajax:success', decide)
$(document).on('ptzcamp:event:update', reloadEvent)
$(document).on('ptzcamp:events:update', reloadEvents)
$(document).on('ptzcamp:event:updated', updateEventParticipants)
$(document).on('click', '[data-action="event-change-decision"]', changeDecision)
