function initMap() {
  var myLatLng = {lat: 37.7886679, lng: -122.4114987};

  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: myLatLng
  });

  var infoWindow = new google.maps.InfoWindow({map: map});

// for geolocation to work, have to run on localhost rather than 0.0.0.0
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };

      infoWindow.setPosition(pos);
      infoWindow.setContent('Location found.');
      map.setCenter(pos);
    }, function() {
      handleLocationError(true, infoWindow, map.getCenter());
    });
  } else {

    // Browser doesn't support Geolocation
    handleLocationError(false, infoWindow, map.getCenter());
  }
}
function handleLocationError(browserHasGeolocation, infoWindow, pos) {
  infoWindow.setPosition(pos);
  infoWindow.setContent(browserHasGeolocation ?
                        'Error: The Geolocation service failed.' :
                        'Error: Your browser doesn\'t support geolocation.');
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
