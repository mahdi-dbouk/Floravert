import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/textinput.dart';
import 'package:image_picker/image_picker.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  String selectedOption = 'natural';
  final TextEditingController _titleInputController = TextEditingController();
  final TextEditingController _descriptionInputController =
      TextEditingController();
  final TextEditingController _quantityInputController =
      TextEditingController();
  final TextEditingController _priceInputController = TextEditingController();
  List<File> selectedImages = [];

  Future getImages() async {
    final pickedFile = await ImagePicker()
        .pickMultiImage(imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    setState(
      () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 32.0,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("back",
                          style: TextStyle(color: Colors.black, fontSize: 16))
                    ],
                  ))
            ],
          ),
          (selectedImages.length != 0)
              ? CarouselSlider.builder(
                  itemCount: selectedImages.length,
                  itemBuilder: (context, index, realIndex) {
                    final File image = selectedImages[index];
                    return Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2))
                      ]),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      padding: EdgeInsets.zero,
                      child: Image.file(
                        image,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  options: CarouselOptions(
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      height: 300,
                      aspectRatio: 1 / 1,
                      enableInfiniteScroll: false))
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  padding: EdgeInsets.zero,
                  child: Image.asset(
                    './assets/placeholder-square.png',
                    fit: BoxFit.cover,
                  )),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: () {
              getImages();
            },
            icon: const Icon(Icons.add_a_photo_outlined),
            label: const Text("Append Image"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
              maxLines: 1,
              controller: _titleInputController,
              label: "Title",
              placeholder: "Title",
              isHidden: false),
          TextInput(
              maxLines: 6,
              controller: _descriptionInputController,
              label: "Desciption",
              placeholder: "Description",
              isHidden: false),
          TextInput(
              maxLines: 1,
              controller: _quantityInputController,
              label: "Quantity",
              placeholder: "Quantity",
              isHidden: false),
          TextInput(
              maxLines: 1,
              controller: _priceInputController,
              label: "Price",
              placeholder: "Price",
              isHidden: false),
          const Center(
            child: Text(
              "Category",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: RadioListTile(
                      value: "natural",
                      title: const Text("Natural"),
                      groupValue: selectedOption,
                      onChanged: (val) {
                        setState(() {
                          selectedOption = val!;
                        });
                      }),
                ),
                Expanded(
                  child: RadioListTile(
                      value: "processed",
                      title: const Text("Processed"),
                      groupValue: selectedOption,
                      onChanged: (val) {
                        setState(() {
                          selectedOption = val!;
                        });
                      }),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: 60,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primary)),
              child: const Text(
                "Add Product",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      )),
    ));
  }
}
