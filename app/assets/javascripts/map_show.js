var map
var marker
var dbLat
var dbLng
function initMap(){
    if(!gon.latitude){
        window.location.reload()
    }
    dbLat = gon.latitude;
    dbLng = gon.longitude;
    geocoder = new google.maps.Geocoder()
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: dbLat, lng: dbLng},
        zoom: 12,
    });
    marker = new google.maps.Marker({
        position: {lat: dbLat, lng: dbLng},
        map: map,
    });
};