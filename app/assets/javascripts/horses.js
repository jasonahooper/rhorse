$(document).ready(function() {
  $('.autocomplete_horse_name').autocomplete({
    minLength: 3,
    source: function(request, response) {
      $.ajax({
        url: $(this.element).data('autocompleteurl'),
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
      $(this.dataset.autocompleteid).val(ui.item.id);
    }, 
    select: function(event, ui) {
      $(this.dataset.autocompleteid).val(ui.item.id);
    } 
/*    return false; ??? */
  })
});
