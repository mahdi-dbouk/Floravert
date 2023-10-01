import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:mobile/models/scanned_pant_data_model.dart';
import 'package:mobile/providers/scanned_plant_provider.dart';
import 'package:mobile/widgets/horizontal_scrollable_widget_list.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

Location location = Location();
bool _serviceEnabled = false;
PermissionStatus _permissionGranted = PermissionStatus.denied;
LocationData _locationData = LocationData.fromMap({});

Future<dynamic> getLocation() async {
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
  }
  _permissionGranted = await location.hasPermission();

  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
  }

  _locationData = await location.getLocation();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    Provider.of<ScannedPlantProvider>(context, listen: false)
        .getAllScannedPlants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    return Consumer<ScannedPlantProvider>(
      builder: (BuildContext context, plantModel, child) => Stack(children: [
        FlutterMap(
          options: MapOptions(
              center: LatLng(_locationData.latitude ?? 45.4408,
                  _locationData.longitude ?? 12.3155),
              zoom: 10.0),
          nonRotatedChildren: [
            RichAttributionWidget(
              animationConfig: const ScaleRAWA(),
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => launchUrl(
                      Uri.parse('https://openstreetmap.org/copyright')),
                ),
              ],
            ),
          ],
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayer(
                markers: allMarkers(plantModel.allPlants, plantModel, context))
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Recently Scanned Plants",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: HorizontallyScrollableSection(
                        scannedPlantModel: Provider.of<ScannedPlantProvider>(
                            context,
                            listen: false)),
                  ),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}

Marker buildMarker(LatLng coordinates, String imageUrl, BuildContext context) {
  return Marker(
      point: coordinates,
      builder: (context) => buildMarkerWidget(imageUrl, context),
      width: 60,
      height: 60);
}

Widget buildMarkerWidget(String imageUrl, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed('/scanned');
    },
    child: Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 3,
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
          shape: BoxShape.circle,
          border: Border.all(width: 2, color: Colors.red)),
      child: CircleAvatar(
        radius: 30,
        backgroundImage:
            NetworkImage(imageUrl ?? "https://i.stack.imgur.com/y9DpT.jpg"),
      ),
    ),
  );
}

List<Marker> allMarkers(
    List plants, ScannedPlantProvider plantModel, BuildContext context) {
  List<Marker> markers = [];
  Marker marker;
  List<ScannedPlant> plants = plantModel.allPlants;
  double lat = 0.0;
  double lng = 0.0;
  plants.forEach((plant) {
    lat = plant.location?.lat ?? 33.9055;
    lng = plant.location?.lng ?? 35.5069;
    marker = buildMarker(LatLng(lat, lng), plant.image!, context);
    markers.add(marker);
  });
  return markers;
}
