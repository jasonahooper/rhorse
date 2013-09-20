$(document).ready(function() {
  $('#horse_sire_name').autocomplete({
    minLength: 3,
    source: function(request, response) {
      $.ajax({
        url: $('#horse_sire_name').data('autocompleteurl'),
        dataType: "json",
        data: {
          name: request.term
        },
        success: function(data) {
          response( $.map( data, function( item ) {
            return {
              label: item.name,
              id: item.id
            }
          }));
        }
      });
    },
    change: function(event, ui) {
      $('#horse_sire_id').val(ui.item.id);
    }, 
    select: function(event, ui) {
      $('#horse_sire_id').val(ui.item.id);
    } 
/*    return false; ??? */
  })
});
