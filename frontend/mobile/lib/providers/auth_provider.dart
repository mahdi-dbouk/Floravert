import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:mobile/models/user_data_model.dart';
import '../config/send_request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as io;

class AuthProvider extends ChangeNotifier {
  User user = User();
  String? token = '';
  String firstname = 'user';

  Future<String> convertImageToBase64(io.File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    String extension = imageFile.path.split('.').last;

    String base64WithExtension = 'data:image/$extension;base64,$base64Image';

    return base64WithExtension;
  }

  void login(String email, String password) async {
    try {
      dynamic response = await sendRequest(
          '/user/login', 'post', {"email": email, "password": password}, '');

      user = User.fromJson(response['user']);

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response['token']);
        token = prefs.getString('token');
        if (token == null) {
          throw Exception("Token is Null!");
        }

        print(token);
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
      dynamic response = await sendRequest('/user/register', 'post', data, '');

      user = User.fromJson(response['user']);

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response['token']);
        prefs = await SharedPreferences.getInstance();
        token = prefs.getString('token')!;
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
          await sendRequest('/user/logout', 'get', {"token": token}, token);

      if (response['message'].isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        token = '';
        user = User();
      }
    } on Exception catch (e) {
      print(e);
    }

    notifyListeners();
  }

  void becomeTrader() async {
    try {
      dynamic response =
          await sendRequest('/user/account/trader', 'post', {}, token);
      user = User.fromJson(response['user']);
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
