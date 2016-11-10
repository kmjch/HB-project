var map, open_now;
var markers = [];


// toggles the form input for 
$('#choose_when').change(showField);

function showField(evt) {
  var chooseWhen = $('#choose_when').val();
  if (chooseWhen === "now") {
    $('#time').css("display", "none");
    open_now = true;
  } else if (chooseWhen === "later") {
    $('#time').css("display", "block");
  }
}

function initMap() {
  var myLatLng = {lat: 37.7886679, lng: -122.4114987};

  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: myLatLng
  });

  var infoWindow;

// for geolocation to work, have to run on localhost rather than 0.0.0.0
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      infoWindow = new google.maps.InfoWindow({map: map});
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


$(document).ready(function() {
  $("#search").click(function(evt) {
    evt.preventDefault();

    var price1 = [];
    $.each($("input[name='price1']:checked"), function() {
      price1.push($(this).val());
    });
    var price2 = [];
    $.each($("input[name='price2']:checked"), function() {
      price2.push($(this).val());
    });

    // creates an object out of the form input values
    var formData = {
      'term1': $('#term1').val(),
      'st_address1': $('#st_address1').val(),
      'city1': $('#city1').val(),
      'state1': $('#state1').val(),
      'radius1': $('#radius1').val(),
      'term2': $('#term2').val(),
      'st_address2': $('#st_address2').val(),
      'city2': $('#city2').val(),
      'state2': $('#state2').val(),
      'radius2': $('#radius2').val(),
      'price1': price1.join(''),
      'price2': price2.join(''),
      'sort_by': $("#sort_by").val(),
      'limit': $("#limit").val()
    };

    if (open_now) {
      formData['open_now'] = true;
    } else {
      formData['time'] = $('#time').val();
    }

    // showing that the page is responding
    $('#search-results').html("loading the best restaurants for you...");


    // should I replace this with a for loop for variable # of people to meet up?

    // show search results based on formData
    $.get('/search.json', formData, function(responses) {
      var businessArray = [];
      for (var i = 0; i < responses['businesses'].length; i++) {
        businessArray.push(
          (i + 1) + ". " + "<a href='" + responses.businesses[i].url + "'>" +
          responses.businesses[i].name + "</a>");
      }
      $('#search-results').html(businessArray.join("<br>"));
      addToMap(responses);
    });
  });
});

function addToMap(responses) {

  // clears map with new search
  function setMapOnAll(map) {
    for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(map);
    }
  }

  setMapOnAll(null);

  // adding person 1 and person 2's locations
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
  markers.push(marker_person1);
  markers.push(marker_person2);
  // do a for loop for when I get more than 2 people meeting up

  // preparing bounds, and adding new markers as I go through the for loop
  var bounds = new google.maps.LatLngBounds();
  var infoWindow = new google.maps.InfoWindow({ width: 150 });

  // looping through each result (up to 20) in the yelp search and extracting lat and lng
  var marker, html;

  for (var i = 0; i < responses['businesses'].length; i++) {

    var coords = [responses.businesses[i].coordinates.latitude, responses.businesses[i].coordinates.longitude];
    var latLng = {lat: coords[0], lng: coords[1]};
    marker = new google.maps.Marker({
      position: latLng,
      label: (i + 1).toString(),
      map: map
    });
    markers.push(marker);

    // define the content of the window
    html = (
            '<div class="window-content">' +
                '<p><b>' + responses.businesses[i].name + '</b></p>' +         // Famous Bao 
                '<p>' + responses.businesses[i].phone + '</p>' +               // phone #
                '<p>' + responses.businesses[i].location.address1 + '</p>' +   // 2431 durant ave
                '<p>' + responses.businesses[i].location.address2 + '</p>' +   // Unit A
                '<p>' + responses.businesses[i].location.city + ', ' +         // Berkeley, CA 94704
                responses.businesses[i].location.state + ' ' +
                responses.businesses[i].location.zip_code + '</p>' +
                '<p>Price level: ' + responses.businesses[i].price + '</p>' +  // Price Level: $
                '<p>Rating: ' + responses.businesses[i].rating + '</p>' +      // Rating: 3.5
                '<p><a href="' + responses.businesses[i].url + '">See ' +      // See Famous Bao on Yelp
                responses.businesses[i].name + ' on Yelp</a></p>' +
            '</div>');
    
    marker.addListener('click', function() {
      infoWindow.open(map, marker);
    });

    bindInfoWindow(marker, map, infoWindow, html);

    // include the new marker in the boundaries of the map
    bounds.extend(marker.getPosition());
  }

  function bindInfoWindow(marker, map, infoWindow, html) {
      google.maps.event.addListener(marker, 'click', function () {
          infoWindow.close();
          infoWindow.setContent(html);
          infoWindow.open(map, marker);
      });
  }

  // map will shift to include all search results
  map.fitBounds(bounds);
}

