import 'package:flutter/material.dart';
import 'package:mobile/models/scanned_pant_data_model.dart';

class ScannedPlantProvider extends ChangeNotifier {
  List<ScannedPlant> _plants = [];
  ScannedPlantProvider(this._plants);

  List<ScannedPlant> get scannedPlants => _plants;

  void setScannedPlants(List<ScannedPlant> plants) {
    _plants = plants;
    notifyListeners();
  }
}
