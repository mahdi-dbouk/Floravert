import 'package:flutter/material.dart';
import 'package:mobile/config/send_request.dart';
import 'package:mobile/models/product_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  ProductProvider(this._products);

  List<Product> get products => _products;

  void setProducts(List<Product> plants) {
    _products = products;
    notifyListeners();
  }

  void getAllProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      dynamic response = await sendRequest('/user/products', 'get', {}, token);
    } catch (e) {
      print(e);
    }
  }
}
