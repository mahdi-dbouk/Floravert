import 'package:flutter/material.dart';
import 'package:mobile/config/send_request.dart';
import 'package:mobile/models/product_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../utils/image_handling.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  ProductProvider(this._products);

  List<Product> get products => _products;

  void setProducts(List<Product> products) {
    _products = products;
  }

  void getAllProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      throw Exception("Token is Null!");
    }
    try {
      dynamic response = await sendRequest('/user/products', 'get', {}, token);
      List<Product> products = [];
      response['data'].forEach((v) {
        products.add(Product.fromJson(v));
      });
      _products = products;
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  void createProduct(String name, String description, String category,
      String totalQuantity, String price, List<File> images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      throw Exception("Token is Null!");
    }
    List<String> base64Images = [];
    String base64Image = '';
    for (var i = 0; i < images.length; i++) {
      base64Image = await Base64ImageHandler().convertToBase64(images[i]);
      base64Images.add(base64Image);
    }

    Product p = Product(
        name: name,
        category: category,
        description: description,
        price: double.parse(price),
        totalQuantity: int.parse(totalQuantity),
        images: base64Images);

    Map<String, dynamic> data = p.toJson();

    try {
      dynamic response =
          await sendRequest('/user/trader/product/add', 'post', data, token);
    } catch (e) {
      rethrow;
    }

    notifyListeners();
  }
}
