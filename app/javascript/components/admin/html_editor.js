window.CKEDITOR.editorConfig = function( config ) {
  // Define changes to default configuration here.
  // For complete reference see:
  // http://docs.ckeditor.com/#!/api/CKEDITOR.config

  // The toolbar groups arrangement, optimized for a single toolbar row.
  config.toolbarGroups = [
    { name: 'document',    groups: [ 'mode', 'document', 'doctools' ] },
    { name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
    { name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
    { name: 'forms' },
    { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
    { name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ] },
    { name: 'links' },
    { name: 'insert' },
    { name: 'styles' },
    { name: 'colors' },
    { name: 'tools' },
    { name: 'others' },
    { name: 'about' }
  ];

  // The default plugins included in the basic setup define some buttons that
  // are not needed in a basic editor. They are removed here.
  config.removeButtons = 'Cut,Copy,Paste,Undo,Redo,Anchor,Underline,Strike,Subscript,Superscript';

  // Dialog windows are also simplified.
  config.removeDialogTabs = 'link:advanced';
};

const CkEditor = {
  start() {
    const ready = () =>
      $('.ckeditor').each(function(_,item) {
        return window.CKEDITOR.replace($(item).attr('id'));
      })
    ;
    $(document).on('turbolinks:load', ready)
  }
};

export default CkEditor;
