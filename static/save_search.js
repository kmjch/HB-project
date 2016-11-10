/* shows the save button when user hovers over the link for the restaurant in
 search results */
$('#choose_when').change(showField);

function showSaveButton(evt) {
  var chooseWhen = $('#choose_when').val();
  if (chooseWhen === "now") {
    $('#time').css("display", "none");
    open_now = true;
  } else if (chooseWhen === "later") {
    $('#time').css("display", "block");
  }
  $('#search-results').html(businessArray.join("<br>"));
}

<div id="save-search">
    <button type="button" id="save_search">Save this search</button>
</div>

$( "li" ).hover(
  function() {
    $( this ).append( $( "<span> ***</span>" ) );
  }, function() {
    $( this ).find( "span:last" ).remove();
  }
);