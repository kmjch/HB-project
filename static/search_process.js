var map;

function initMap() {
  var myLatLng = {lat: 37.7886679, lng: -122.4114987};

  map = new google.maps.Map(document.getElementById('map'), {
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
      $('#search-results').html(responses.businesses[0].name);
      addToMap(responses);
    });
  });
});

function addToMap(responses) {
  console.log("adding markers to the map");
  var marker_person1 = new google.maps.Marker({
      position: {lat: responses.person1[0], lng: responses.person1[1]},
      label: "Person 1",
      map: map
  });
  var marker_person2 = new google.maps.Marker({
      position: {lat: responses.person2[0], lng: responses.person2[1]},
      label: "Person 2",
      map: map
  });
  // do a for loop for when I get more than 2 people meeting up
  for (var i = 0; i < responses['businesses'].length; i++) {
    var coords = [responses.businesses[i].coordinates.latitude, responses.businesses[i].coordinates.longitude];
    var latLng = {lat: coords[0], lng: coords[1]};
    // var minLat = 
    var marker = new google.maps.Marker({
      position: latLng,
      label: (i + 1).toString(),
      map: map
    });
  }
  map.setCenter({lat: responses.midpt[0], lng: responses.midpt[1]});
}

// function minValue(value) {
//   var comparedVal = value;
//   if (value < comparedVal) {
    
//   }
// }
// function maxValue(value, comparedVal = -181) {
//   if ()
// }
