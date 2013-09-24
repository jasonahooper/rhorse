var CtreeFilter = {
  filter_text: function() {
    $('tr').hide();
    var search = document.getElementById("filterText").value;
    $('tr:cicontains("' + search + '")').show();
  },
  setup: function() {
    var textboxAndButton =
      $('<input type="text" id="filterText"/> ' +
        '<input type="button" id="filterButton" value="Filter"/><br /><br />');
    textboxAndButton.insertBefore('#ctree'); 
    $('#filterButton').click(CtreeFilter.filter_text); 
  }
}
$(CtreeFilter.setup);
$.expr[":"].cicontains = $.expr.createPseudo(function(arg) {
    return function( elem ) {
        return $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
    };
});
