import 'package:flutter/material.dart';

class MapActionButton extends StatefulWidget {
  const MapActionButton({super.key});

  @override
  State<MapActionButton> createState() => _MapActionButtonState();
}

class _MapActionButtonState extends State<MapActionButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: Icon(
          Icons.pin_drop_outlined,
          size: 36,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
