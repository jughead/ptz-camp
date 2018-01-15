window.ptzcamp ||= {}
window.ptzcamp.form_helpers ||=
  requiredText: () ->
    'required'

  requireFormGroup: (elements) ->
    elements.each () ->
      $this = $(this)
      label = $this.find('label.control-label')
      if label.find('abbr').length == 0
        $this.find(':input').addClass('required').attr('required', 'required')
        label.addClass('required')
        $this.addClass('required')
        label.html(
          $('<p/>').append(
            $('<abbr>*</abbr>').attr('title', ptzcamp.form_helpers.requiredText())
          ).append(' ').append(label.text()).html()
        )

  unrequireFormGroup: (elements) ->
    elements.each () ->
      $this = $(this)
      label = $this.find('label.control-label')
      abbr = label.find('abbr')
      if abbr.length > 0
        $this.find(':input').removeClass('required').removeAttr('required')
        label.removeClass('required')
        $this.removeClass('required')
        abbr.remove()
        label.text(label.text()[1..-1])
