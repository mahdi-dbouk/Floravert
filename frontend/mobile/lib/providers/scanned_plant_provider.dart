import 'package:flutter/material.dart';
import 'package:mobile/config/send_request.dart';
import 'package:mobile/models/scanned_pant_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../utils/image_handling.dart';

class ScannedPlantProvider extends ChangeNotifier {
  List<ScannedPlant> _plants = [];
  List<ScannedPlant> _all = [];
  ScannedPlantProvider(this._plants);

  List<ScannedPlant> get scannedPlants => _plants;
  List<ScannedPlant> get allPlants => _all;

  void setScannedPlants(List<ScannedPlant> plants) {
    _plants = plants;
    notifyListeners();
  }

  void getAllScannedPlants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      throw Exception("Token is Null!");
    }
    try {
      dynamic response =
          await sendRequest('/user/scanned/get/all', 'get', {}, token);
      List<ScannedPlant> allPlants = [];
      response['data'].forEach((v) {
        allPlants.add(ScannedPlant.fromJson(v));
      });
      _all = allPlants;
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  void sendScannedPhotoToServer(File? image) async {
    if (image == null) {
      throw Exception("Image is Null");
    }
    String base64Image = await Base64ImageHandler().convertToBase64(image);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      throw Exception("Token is Null!");
    }

    try {
      dynamic response = await sendRequest(
          '/user/scanned/apis/3rd_party/openai/generate',
          'post',
          {'base64Image': base64Image},
          token);
    } catch (e) {
      rethrow;
    }
  }
}
