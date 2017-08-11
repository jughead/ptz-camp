//= require ckeditor/init
//= require ckeditor/ckeditor

const ready = () =>
  $('.ckeditor').each(function() {
    return CKEDITOR.replace($(this).attr('id'));
  })
;

$(document).ready(ready);
