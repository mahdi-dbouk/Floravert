import 'package:flutter/material.dart';
import 'package:mobile/widgets/textinput.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  String selectedOption = 'natural';
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
          Container(
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
            onPressed: () {},
            icon: const Icon(Icons.add_a_photo_outlined),
            label: const Text("Append Image"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
              controller: TextEditingController(),
              label: "Title",
              placeholder: "Title",
              isHidden: false),
          TextInput(
              controller: TextEditingController(),
              label: "Desciption",
              placeholder: "Description",
              isHidden: false),
          TextInput(
              controller: TextEditingController(),
              label: "Quantity",
              placeholder: "Quantity",
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
