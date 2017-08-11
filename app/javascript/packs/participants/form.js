let Form = class Form {
  constructor(element) {
    this.element = element;
    this.update();
    this.register();
  }

  update() {
    if (this.needsVisaElement().is(':checked')) {
      this.requireVisaBlock();
      return this.visaBlock().show();
    } else {
      this.unrequireVisaBlock();
      return this.visaBlock().hide();
    }
  }

  requiredFormGroups() {
    return this.visaBlock().find('.form-group').filter(function() {
      return $(this).find(':input[type=file]').length === 0;
    });
  }

  requireVisaBlock() {
    ptzcamp.form_helpers.requireFormGroup(this.requiredFormGroups());
  }

  unrequireVisaBlock() {
    ptzcamp.form_helpers.unrequireFormGroup(this.requiredFormGroups());
  }

  register() {
    this.needsVisaElement().on('change', this.update.bind(this));
  }

  visaBlock() {
    return this.element.find('.for_visa');
  }

  needsVisaElement() {
    this.element.find('#participant_personal_needs_visa');
  }

  static handler() {
    return $('form.new_participant,form.edit_participant').each(function() {
      const $this = $(this);
      if (!this.participant_form) {
        return this.participant_form = new Form($this);
      }
    });
  }

  static register() {
    $(document).on('turbolinks:load', this.handler);
    return $(document).ready(this.handler);
  }
};

module.exports = {
  form: Form,
}
