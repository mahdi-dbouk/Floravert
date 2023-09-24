import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import '/widgets/textinput.dart';

class Register extends StatefulWidget {
  final fullNameInputController = TextEditingController();

  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16))
                        ],
                      ))
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
                  controller: widget.fullNameInputController,
                  label: "Full Name",
                  placeholder: "First Name",
                  isHidden: false),
              TextInput(
                  controller: TextEditingController(),
                  label: "Email",
                  placeholder: "Email",
                  isHidden: false),
              TextInput(
                  controller: TextEditingController(),
                  label: "Password",
                  placeholder: "Password",
                  isHidden: true),
              TextInput(
                  controller: TextEditingController(),
                  label: "Confirm Password",
                  placeholder: "Confirm Password",
                  isHidden: true),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/setup');
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
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Text(
                    "OR",
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade400,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      print(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.white),
                      side: MaterialStatePropertyAll(BorderSide(
                        color: Colors.grey.shade200,
                      )),
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "Sign Up with Google",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Image.asset(
                                  'assets/google.svg.png',
                                  scale: 25,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      })
              ]))
            ],
          )),
        ));
  }
}
