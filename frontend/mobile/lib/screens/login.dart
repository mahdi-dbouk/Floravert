import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mobile/models/scanned_pant_data_model.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:mobile/providers/scanned_plant_provider.dart';
import 'package:mobile/screens/register.dart';
import 'package:provider/provider.dart';
import '/widgets/textinput.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authUserModel, child) => Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
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
                          Navigator.of(context)
                              .pushReplacementNamed('/register');
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16))
                          ],
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/floravert_logo.png',
                      scale: 5,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                TextInput(
                    maxLines: 1,
                    controller: emailInputController,
                    label: "Email",
                    placeholder: "Email",
                    isHidden: false),
                TextInput(
                    maxLines: 1,
                    controller: passwordInputController,
                    label: "Password",
                    placeholder: "Password",
                    isHidden: true),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        try {
                          Provider.of<AuthProvider>(context, listen: false)
                              .login(emailInputController.text.toString(),
                                  passwordInputController.text.toString());
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            Provider.of<ScannedPlantProvider>(context,
                                    listen: false)
                                .setScannedPlants(List<ScannedPlant>.from(
                                    authUserModel.user.scannedPlants ?? []));
                            Navigator.of(context).pushReplacementNamed('/');
                          } on Exception {
                            rethrow;
                          }
                        } catch (e) {
                          setState(() {});
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.primary),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: (isLoading)
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text("Log In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Don't Have an Account?",
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 16)),
                  const TextSpan(text: " "),
                  TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        })
                ]))
              ],
            )),
          )),
    );
  }
}
