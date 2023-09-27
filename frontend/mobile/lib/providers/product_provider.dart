import 'package:flutter/material.dart';
import 'package:mobile/models/product_data_model.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  ProductProvider(this._products);

  List<Product> get products => _products;

  void setProducts(List<Product> plants) {
    _products = products;
    notifyListeners();
  }
}
