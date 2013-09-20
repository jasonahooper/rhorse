$(document).ready(function() {
  $('#horse_sire_name').autocomplete({
    minLength: 3,
    source: function(request, response) {
      $.ajax({
        url: 'complete_sire_name',
        dataType: "json",
        data: {
          name: request.term
        },
        success: function(data) {
          response(data);
        }
      });
    },
    focus: function(event, ui) {
      $('#horse_sire_name').val(ui.item.name);
      return false;
    },
    select: function(event, ui) {
      $('#horse_sire_name').val(ui.item.name);
      $('#horse_sire_id').val(ui.item.id);
      return false;
    }
  })
 .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
      return $( "<li></li>" )
        .append( "<a>" + item.name + "</a>" )
        .appendTo( ul );
});
