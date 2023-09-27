import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:mobile/models/scanned_pant_data_model.dart';
import 'package:mobile/models/user_data_model.dart';
import 'package:mobile/providers/scanned_plant_provider.dart';
import 'package:provider/provider.dart';
import '../config/send_request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as io;

class AuthProvider extends ChangeNotifier {
  User user = User();
  String token = '';
  String firstname = 'user';

  Future<String> convertImageToBase64(io.File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    String extension = imageFile.path.split('.').last;

    String base64WithExtension = 'data:image/$extension;base64,$base64Image';

    return base64WithExtension;
  }

  void login(String email, String password, BuildContext ctx) async {
    try {
      dynamic response = await sendRequest(
          '/user/login', 'post', {"email": email, "password": password}, '');

      user = User.fromJson(response['user']);

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response['token']);
      } on Exception catch (e) {
        print(e);
      }

      try {
        Provider.of<ScannedPlantProvider>(ctx, listen: false).setScannedPlants(
            List<ScannedPlant>.from(user.scannedPlants ?? []));
      } on Exception catch (e) {
        print(e);
      }
    } catch (e) {
      rethrow;
    }

    notifyListeners();
  }

  void register(
      String firstName,
      String lastName,
      String username,
      String email,
      String password,
      String phone,
      int age,
      io.File profilePicture) async {
    String base64Profile = await convertImageToBase64(profilePicture);
    print(base64Profile);

    Map<String, dynamic> data = {
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "age": age,
      "email": email,
      "base64Image": base64Profile,
      "phone": phone,
      "password": password
    };

    try {
      print(data);
      dynamic response = await sendRequest('/user/register', 'post', data, '');

      user = User.fromJson(response['user']);

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response['token']);
      } on Exception catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    try {
      dynamic response =
          await sendRequest('/user/logout', 'post', {"token": token}, token);

      if (response['message']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', '');
      }
    } on Exception catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
