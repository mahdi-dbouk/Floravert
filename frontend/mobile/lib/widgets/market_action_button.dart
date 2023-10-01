import 'package:flutter/material.dart';
import 'package:mobile/providers/product_provider.dart';
import 'package:provider/provider.dart';

class MarketActionButton extends StatefulWidget {
  const MarketActionButton({super.key});

  @override
  State<MarketActionButton> createState() => _MarketActionButtonState();
}

class _MarketActionButtonState extends State<MarketActionButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add/product').then((value) =>
              Provider.of<ProductProvider>(context).getAllProducts());
        },
        backgroundColor: Colors.amber,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.post_add,
          size: 36,
          color: Colors.black,
        ),
      ),
    );
  }
}
