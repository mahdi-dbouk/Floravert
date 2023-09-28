import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
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
  Widget build(BuildContext context) {
    getLocation();
    return Stack(children: [
      FlutterMap(
        options: MapOptions(
            center: LatLng(
                _locationData.latitude ?? 0.0, _locationData.longitude ?? 0.0),
            zoom: 10.0),
        nonRotatedChildren: [
          RichAttributionWidget(
            animationConfig: const ScaleRAWA(),
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          const MarkerLayer()
        ],
      ),
    ]);
  }
}
