window.ptzcamp ||= {}
window.ptzcamp.participants ||= {}
window.ptzcamp.participants.Form = class Form
  constructor: (@element) ->
    @update()
    @register()

  update: () ->
    if @needsVisaElement().is(':checked')
      @requireVisaBlock()
      @visaBlock().show()
    else
      @unrequireVisaBlock()
      @visaBlock().hide()

  requiredFormGroups: () ->
    @visaBlock().find('.form-group').filter () ->
      $(this).find(':input[type=file]').length == 0

  requireVisaBlock: () ->
    ptzcamp.form_helpers.requireFormGroup @requiredFormGroups()

  unrequireVisaBlock: () ->
    ptzcamp.form_helpers.unrequireFormGroup @requiredFormGroups()

  register: () ->
    @needsVisaElement().on 'change', @update.bind(this)

  visaBlock: () ->
    @element.find('.for_visa')

  needsVisaElement: () ->
    @element.find('#participant_personal_needs_visa')

  @handler: () ->
    $('form.new_participant,form.edit_participant').each () ->
      $this = $(this)
      unless this.participant_form
        this.participant_form = new Form($this)

  @register: () ->
    $(document).on 'turbolinks:load', this.handler
    $(document).ready this.handler
