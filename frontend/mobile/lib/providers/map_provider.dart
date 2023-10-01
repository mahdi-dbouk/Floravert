import 'package:flutter/material.dart';

class MapProvider extends ChangeNotifier {
  double lat = 0.0;
  double lng = 0.0;
  void getLocation(double lat_, double lng_) {
    lat = lat_;
    lng = lng_;

    notifyListeners();
  }
}
