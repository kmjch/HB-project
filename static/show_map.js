var map;
      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: 37.7886679, lng: -122.4114987},
          // how to pass in variables to javascript files?
          zoom: 16
        });
      }

function addMarker() {
  var myImageURL = 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png';
  var image = myImageURL;
  var hackbright = new google.maps.LatLng(37.7886679, -122.4114987);
}