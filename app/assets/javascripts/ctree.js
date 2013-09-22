var CtreeFilter = {
  filter_text: function() {
    $('div>div').hide();
    var search = document.getElementById("filterText").value;
    $('div:contains("' + search + '")').show();
  },
  setup: function() {
    var textboxAndButton =
      $('<input type="text" id="filterText"/>' +
        '<input type="button" id="filterButton" value="Filter"/>');
    textboxAndButton.insertBefore('#ctree'); 
    $('#filterButton').click(CtreeFilter.filter_text); 
  }
}
$(CtreeFilter.setup);
