$(document).ready(function(evt) {
  $("#search").click(function(evt) {
    evt.preventDefault();
    // gather form data in an object called formData
    var term1 = $('#term1').val();
    var st_address1 = $('#st_address1').val();
    var city1 = $('#city1').val();
    var state1 = $('#state1').val();
    var radius1 = $('#radius1').val();
    var term2 = $('#term2').val();
    var st_address2 = $('#st_address2').val();
    var city2 = $('#city2').val();
    var state2 = $('#state2').val();
    var radius2 = $('#radius2').val();
    // get search results based on the formData
  });
});

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

// to do:
// can pass in object coordinates = {'lat': latitude, 'lng': longitude} from python to html as jinja variable {{ coordinates }}
