var CtreeFilter = {
  // only show data that case-insensitively contains the search term
  filter_text: function() {
    $('tr').hide();
    var search = document.getElementById("filterText").value.split(",");
    for (var i=0; i<search.length; i++) {
      $('tr:cicontains("' + $.trim(search[i]) + '")').show();
    }
  },
  // add a text input and a button to the form
  setup: function() {
    var textboxAndButton =
      $('' + 
        '<input type="button" id="filterButton" value="Filter"/> ' +
        '<input type="text" id="filterText"/> ' +
        'Enter terms to filter with separated by commas.' +
        '<br /><br />');
    textboxAndButton.insertBefore('#ctree'); 
    $('#filterButton').click(CtreeFilter.filter_text); 
  }
}
// execute the function to setup the new items
$(CtreeFilter.setup);
// a custom function to do a case-insensitive contains - the JQuery contains is case sensitive
$.expr[":"].cicontains = $.expr.createPseudo(function(arg) {
    return function( elem ) {
        return $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
    };
});
