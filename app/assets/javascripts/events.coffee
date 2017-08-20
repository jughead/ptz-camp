decide = (event, data, status) ->
  console.log "Successful decision"
  console.log data
  console.log $(event.target)
  if data.success
    $(event.target).closest('.event-list').replaceWith(data.html)

changeDecision = () ->
  $this = $(this)
  $this.closest('.event-option-buttons').find('.button-group').removeClass('hide')
  $this.remove()

$(document).on('ajax:success', decide)
$(document).on('click', '[data-action="event-change-decision"]', changeDecision)
