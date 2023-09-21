import 'package:flutter/material.dart';
import '/widgets/textinput.dart';

class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            style: TextStyle(color: Colors.black, fontSize: 16))
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
            TextInput(
                controller: TextEditingController(),
                label: "Username",
                placeholder: "Username",
                isHidden: false),
            TextInput(
                controller: TextEditingController(),
                label: "Date of Birth *",
                placeholder: "Choose a Date",
                isHidden: false),
            DatePickerDialog(
                initialDate: DateTime(2000),
                firstDate: DateTime(2000),
                lastDate: DateTime(2023)),
            TextInput(
                controller: TextEditingController(),
                label: "Phone *",
                placeholder: "+0000 00000000",
                isHidden: false),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
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
        ));
  }
}
