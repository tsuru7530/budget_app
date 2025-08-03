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
        draggable: true,
    });
    google.maps.event.addListener(marker, 'dragend', function(e){
        var hiddenLat = document.getElementById("hidden_latitude")
        var hiddenLng = document.getElementById("hidden_longitude")
        var latitude = e.latLng.lat()
        var longitude = e.latLng.lng()
        hiddenLat.value = latitude
        hiddenLng.value = longitude
    });
    var searchBtn = document.getElementById('search_address')
    searchBtn.addEventListener('click', (e) => {
        e.preventDefault()
        inputStr = document.getElementById('input_address').value
        geocoder.geocode({'address': inputStr}, function(results, status){
            if (status == 'OK') {
                latitude = results[0].geometry.location.lat()
                longitude = results[0].geometry.location.lng()
                document.getElementById("hidden_latitude").value = latitude
                document.getElementById("hidden_longitude").value = longitude
            map = new google.maps.Map(document.getElementById('map'), {
                center: {lat: latitude, lng: longitude},
                zoom: 12,
            });
            marker = new google.maps.Marker({
                position: {lat: latitude, lng: longitude},
                map: map,
                draggable: true,
            });
            } else {
                alert('該当の住所が見つかりませんでした')
            }
        })
    })
};