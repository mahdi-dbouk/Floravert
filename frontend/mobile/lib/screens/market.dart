import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class Product {
  String? url;
  String? name;
  String? price;
  bool? isAvailable;
  Product({this.url, this.name, this.price, this.isAvailable});
}

class _MarketState extends State<Market> {
  final TextEditingController _searchInputController = TextEditingController();
  int _selectedOption = 0;
  List products = [];

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
