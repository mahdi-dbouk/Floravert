import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '/widgets/textinput.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _fullNameInputController =
      TextEditingController();
  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  final TextEditingController _confirmPasswordInputController =
      TextEditingController();
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
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                TextInput(
                    controller: _fullNameInputController,
                    label: "Full Name",
                    placeholder: "First Name",
                    isHidden: false),
                TextInput(
                    controller: _emailInputController,
                    label: "Email",
                    placeholder: "Email",
                    isHidden: false),
                TextInput(
                    controller: _passwordInputController,
                    label: "Password",
                    placeholder: "Password",
                    isHidden: true),
                TextInput(
                    controller: _confirmPasswordInputController,
                    label: "Confirm Password",
                    placeholder: "Confirm Password",
                    isHidden: true),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/setup', arguments: {
                          "email": _emailInputController.text,
                          "fullname": _fullNameInputController.text,
                          "password": _passwordInputController.text
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.primary),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text("Sign Up",
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
                      text: "Already a user?",
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 16)),
                  const TextSpan(text: " "),
                  TextSpan(
                      text: "Login",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context)
                            .pushReplacementNamed('/login'))
                ]))
              ],
            )),
          )),
    );
  }
}
