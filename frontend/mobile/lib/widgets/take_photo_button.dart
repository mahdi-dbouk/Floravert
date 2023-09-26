import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:mobile/screens/scanresults.dart';

class NavBarImageButton extends StatefulWidget {
  const NavBarImageButton({super.key});

  @override
  State<NavBarImageButton> createState() => _NavBarImageButtonState();
}

class _NavBarImageButtonState extends State<NavBarImageButton> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScannedResult(image: _image)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: FloatingActionButton(
        onPressed: () {
          _pickImage();
        },
        backgroundColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.camera_alt_outlined,
          size: 36,
          color: Colors.white,
        ),
      ),
    );
  }
}
