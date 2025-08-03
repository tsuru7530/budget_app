var markers
var infoWindows
var locationDatas
var marker
function initMap(){
  markers = []
  infoWindows = []
  locationDatas = []
  if (!gon.districts) {
    window.location.reload()
  }
  for (var i = 0; i < gon.districts.length; i++) {
    locationDatas.push(gon.districts[i])
  }
  geocoder = new google.maps.Geocoder()
  map = new google.maps.Map(document.getElementById('map_index'), {
    center: {
      lat: Number(locationDatas[0]['latitude']), 
      lng: Number(locationDatas[0]['longitude'])
    },
    zoom: 12,
  })
  for (var j = 0; j < locationDatas.length; j++) {
    markers[j] = new google.maps.Marker({
        position: {
          lat: Number(locationDatas[j]['latitude']), 
          lng: Number(locationDatas[j]['longitude'])
        },
        map: map,
    });
    infoWindows[j] = new google.maps.InfoWindow({
       content: '<a href="/districts/' + locationDatas[j]['id'] + '">' + locationDatas[j]['name'] +'</a>'
    })
    markerClick(j, map)
  }
}
function markerClick(j, map){
  markers[j].addListener('click', function(){
    infoWindows[j].open(map, markers[j])
  })
}