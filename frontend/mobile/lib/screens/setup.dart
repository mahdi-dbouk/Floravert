import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '/widgets/textinput.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  File? _image;

  TextEditingController dateTimeFieldInputController = TextEditingController();
  TextEditingController userNameFieldInputController = TextEditingController();
  String phoneNumber = "";

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    final Map<String, dynamic>? args = arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Invalid arguments'),
        ),
      );
    }
    final String? fullName = arguments!['fullname'];
    final String? email = arguments['email'];
    final String? password = arguments['password'];
    return Consumer<AuthProvider>(
      builder: (context, authUserModel, child) => Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SingleChildScrollView(
            child: SafeArea(
                child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16))
                        ],
                      ))
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Let's Get You Ready!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green, width: 2)),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : const AssetImage(
                                  'assets/green_placeholder_avatar.jpg')
                              as ImageProvider,
                    ),
                  ),
                  Positioned(
                      top: 148,
                      left: 56,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.green, width: 2),
                            color: Colors.white),
                        child: IconButton(
                            color: Colors.green,
                            onPressed: _pickImage,
                            icon: const Icon(Icons.add_a_photo)),
                      ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextInput(
                controller: userNameFieldInputController,
                label: "Username",
                placeholder: "Username",
                isHidden: false,
                maxLines: 1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: DateTimeField(
                  controller: dateTimeFieldInputController,
                  format: DateFormat('d/M/y'),
                  initialValue: DateTime(2005),
                  readOnly: true,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Date of Birth*",
                      hintText: "Date of Birth*",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.normal,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade400, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      suffixIcon: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.green,
                      )),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1970),
                        lastDate: DateTime(2005));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber phone) {
                    phoneNumber = phone.phoneNumber!;
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    setSelectorButtonAsPrefixIcon: true,
                    leadingPadding: 10.0,
                  ),
                  inputDecoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Phone*",
                      hintText: "Phone*",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.normal,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade400, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      suffixIcon: const Icon(
                        Icons.phone_android_outlined,
                        color: Colors.green,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      List<String> fullNameList = fullName!.split(' ');
                      int age = calculateAge(dateTimeFieldInputController.text);
                      try {
                        Provider.of<AuthProvider>(context, listen: false)
                            .register(
                                fullNameList[0],
                                fullNameList[1],
                                userNameFieldInputController.text,
                                email!,
                                password!,
                                phoneNumber,
                                age,
                                _image!);
                        Navigator.of(context).pushReplacementNamed('/');
                      } catch (e) {
                        setState(() {});
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.primary),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("Create Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ])),
          )),
    );
  }

  int calculateAge(String birthDateString) {
    DateTime currentDate = DateTime.now();
    DateFormat format = DateFormat('M/d/yyyy');
    DateTime birthDate = format.parse(birthDateString);
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}
