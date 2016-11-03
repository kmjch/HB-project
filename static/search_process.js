function initMap() {
        var myLatLng = {lat: 37.7886679, lng: -122.4114987};

        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 16,
          center: myLatLng
        });

        var marker = new google.maps.Marker({
          position: myLatLng,
          map: map,
          title: 'Hello World!'
        });
}


$(document).ready(function(evt) {
  $("#search").click(function(evt) {
    evt.preventDefault();

    // creates an object out of the form input values
    var formData = {
      term1: $('#term1').val(),
      st_address1: $('#st_address1').val(),
      city1: $('#city1').val(),
      state1: $('#state1').val(),
      radius1: $('#radius1').val(),
      term2: $('#term2').val(),
      st_address2: $('#st_address2').val(),
      city2: $('#city2').val(),
      state2: $('#state2').val(),
      radius2: $('#radius2').val()
    };

    // showing that the page is responding
    $('#search-results').html("loading the best restaurants for you...");


    // should I replace this with a for loop for variable # of people to meet up?

    // show search results based on formData
    $.get('/search.json', formData, function(responses) {
      $('#search-results').html(responses['businesses'][0]['name']);
    });
  });
});



// to do:
// can pass in object coordinates = {'lat': latitude, 'lng': longitude} from python to html as jinja variable {{ coordinates }}
