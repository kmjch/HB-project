var map, openNow;
var markers = [];

// toggles the form input for midpoint or venn diagram
$('#search-type').change(changeFormType);
var chooseType = $('#search-type').val();
function changeFormType(evt) {
  chooseType = $('#search-type').val();
  if (chooseType === "venn") {
    $('.midpt-fields').css("display", "none");
  } else if (chooseType === "midpt") {
    $('.midpt-fields').css("display", "block");
  }
}

// toggles the form input for searching time to meet up
$('#choose_when').change(showTimeField);

function showTimeField(evt) {
  console.log(evt);

  var chooseWhen = evt.target.value;
  if (chooseWhen === "now") {
    $('#time').css("display", "none");
    openNow = true;
    console.log(openNow);
  } else if (chooseWhen === "later") {
    $('#time').css("display", "block");
    console.log($('#time').val());
  }
}

function adder(x, y) {
    return x + y;
}
var loc1, loc2;
function autocompleteBox() {
  var input1 = document.getElementById('loc1');
  var input2 = document.getElementById('loc2');
  var searchBox1 = new google.maps.places.SearchBox(input1);
  var searchBox2 = new google.maps.places.SearchBox(input2);

  searchBox1.addListener('places_changed', function() {
    loc1 = searchBox1.getPlaces()[0];
    console.log(loc1);
    if (loc1.length === 0) {
      // no results
      return;
    }
  });
  searchBox2.addListener('places_changed', function() {
    loc2 = searchBox2.getPlaces()[0];
    console.log(loc2);
    if (loc2.length === 0) {
      // no results
      return;
    }
  });

  // searchBox1.addListener('places_changed', getCoordinates(searchBox1));
  // searchBox2.addListener('places_changed', getCoordinates(searchBox2));

}

function initMap() {
  var myLatLng = {lat: 37.7886679, lng: -122.4114987};
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: myLatLng
  });
  autocompleteBox();


  var infoWindow;

// for geolocation to work, have to run on localhost rather than 0.0.0.0
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      // infoWindow = new google.maps.InfoWindow({map: map});
      // infoWindow.setPosition(pos);
      // infoWindow.setContent('Location found.');
      map.setCenter(pos);
    }, function() {
      // handleLocationError(true, infoWindow, map.getCenter());
      handleLocationError(true, map.getCenter());
    });
  } else {

    // Browser doesn't support Geolocation
    // handleLocationError(false, infoWindow, map.getCenter());
    handleLocationError(false, map.getCenter());
  }
}

// function handleLocationError(browserHasGeolocation, infoWindow, pos) {
//   infoWindow.setPosition(pos);
//   infoWindow.setContent(browserHasGeolocation ?
//                         'Error: The Geolocation service failed.' :
//                         'Error: Your browser doesn\'t support geolocation.');
// }


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
      'search-type': chooseType,
      'term1': $('#term1').val(),
      'lat1': loc1.geometry.location.lat(),
      'lng1': loc1.geometry.location.lng(),
      'lat2': loc2.geometry.location.lat(),
      'lng2': loc2.geometry.location.lng(),
      'radius1': $('#radius1').val(),
      'price1': price1.join(''),
      'price2': price2.join(''),
      'limit': $("#limit").val(),
    };

    // Adding more parameters for midpoint calculation if chosen
    if (chooseType === 'midpt') {
      formData['radius2'] = $('#radius2').val();
      formData['sort_by'] = $("#sort_by").val();
      formData['term2'] = $('#term2').val();
    }

    // toggling between open now and open at
    if (openNow) {
      formData['openNow'] = true;
    } else {
      formData['time'] = $('#time').val();
    }

    // showing that the page is responding
    $('#search-results').html("loading the best restaurants for you...");


    // should I replace this with a for loop for variable # of people to meet up?

    // show search results based on formData, looping through to list names
    $.get('/search.json', formData, function(responses) {
      var businessArray = ["<ol id='results_list'>"];
      for (var i = 0; i < responses['businesses'].length; i++) {
        var name = responses.businesses[i].name;
        var url = responses.businesses[i].url;
        var id = responses.businesses[i].id;
        businessArray.push(
          "<li class='result' id='search-result" + i + "' data-id='" + id +
          "' data-name='" + name + "'><a href='" + url + "'>" + name + "</a></li>");
      }
      businessArray.push("</ol>");
      $('#search-results').html(businessArray.join(""));

      // add search results as markers onto the map
      addToMap(responses);
      
      // hover over the business listing to be able to save
      $(".result").hover(function() {
        // when you mouse over the link, a button to save the location appears
        var id = $(this).data('id');
        var name = $(this).data('name');
        $(this).append($("<span id='popup'> <button type='button' data-id='" + id +
          "' data-name='" + name + "' id='save_search_result'>Save this location" +
          "</button></span>"));

        // when you click the button to save location, a form appears to ask more
        $('#save_search_result').click(function (evt) {
          $('#popup').append($("<span><form> <label>With whom? <input type='text'" +
            "id='with_whom'></label> <label>When? <input type='date' id='when'></label>" +
            "<label>Rating <input type='num' id='rating'></label> <button type='button'" +
            " data-id='" + id + "' data-name='" + name + "' id='save_visit'>Save" +
            "</button></form></span>"));

          // when you click on save, sends an ajax request to save to the database
          $('#save_visit').click(function (evt) {
            var id = $(this).data('id');
            var name = $(this).data('name');
            var visitData = {
              'friend': $('#with_whom').val(),
              'when': $('#when').val(),
              'rating': $('#rating').val(),
              'restaurant': name,
              'yelp_id': id,
            };
            // sending the object visitData to server.py
            $.get('/add_visit.json', visitData, function (results) {
              $('#popup').html(results);
            });
          });
        });
        // when your mouse leaves the link
        }, function() {
          $(this).find('#popup').remove();
          $(this).find('span:last').remove();
        }
      );

    });
  });
});

// function addHovers() {


    
// }

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
  markers.push(marker_person1);

  var marker_person2 = new google.maps.Marker({
      position: {lat: responses.person2[0], lng: responses.person2[1]},
      label: "Person 2",
      map: map
  });
  markers.push(marker_person2);

  // do a for loop for when I get more than 2 people meeting up

  // preparing bounds, and adding new markers as I go through the for loop
  var bounds = new google.maps.LatLngBounds();
  var infoWindow = new google.maps.InfoWindow({ width: 150 });

  // looping through each result (up to 20) in the yelp search and extracting lat and lng
  var marker, html;

  for (var i = 0; i < responses['businesses'].length; i++) {

    var coords = [responses.businesses[i].coordinates.latitude,
                  responses.businesses[i].coordinates.longitude];
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
    for (var j = 0; j < markers.length; j++) {
      bounds.extend(markers[i].getPosition());
    }
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

