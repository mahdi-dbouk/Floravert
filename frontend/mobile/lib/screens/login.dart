import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mobile/screens/register.dart';
import '/widgets/textinput.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
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
                        Navigator.of(context).pushNamed('/register');
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
                  controller: TextEditingController(),
                  label: "Email",
                  placeholder: "Email",
                  isHidden: false),
              TextInput(
                  controller: TextEditingController(),
                  label: "Password",
                  placeholder: "Password",
                  isHidden: true),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.primary),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: (_isLoading)
                          ? const CircularProgressIndicator(color: Colors.white)
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
                    onPressed: () {},
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
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "Log In with Google",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
        ));
  }
}
