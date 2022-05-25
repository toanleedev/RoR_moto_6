// // Instantiate (and display) a map object:
// $(document).ready(function () {
//   var latlng = [16.059112854051588, 108.21137672402146];
//   var map = L.map('map', { closePopupOnClick: false }).setView(latlng, 13);

//   L.tileLayer(
//     'https://{s}.tile.jawg.io/jawg-streets/{z}/{x}/{y}{r}.png?access-token=jYqm4o1rsORk0AfjIxBaSlD7we3jP0ntqY6rOGUDwfROiD9h2BGNEjpLmncMfLCm',
//     {
//       minZoom: 6,
//       maxZoom: 18,
//       id: 'mapbox.streets',
//     }
//   ).addTo(map);

//   var popup1 = L.popup({ closeButton: false, closeOnEscapeKey: false })
//     .setLatLng([16.0596654344819, 108.2225087822442])
//     .setContent('<a href="#">200k</a>')
//     .addTo(map);
//   var popup = L.popup({ closeButton: false, closeOnEscapeKey: false })
//     .setLatLng([16.059112854051588, 108.21137672402146])
//     .setContent('<span>20k</span>')
//     .addTo(map);
// });
