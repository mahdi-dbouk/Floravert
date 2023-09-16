import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'register.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.none,
            scale: 0.7,
          )),
        ),
        SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Center(
                child: Text(
                  "Floravert",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            color: Color.fromARGB(25, 0, 0, 0),
                            blurRadius: 4.0,
                            offset: Offset(2, 2))
                      ]),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Center(
                child: Text(
                  "Your AI-powered Herbalist friend to accompany you on your outdoors adventures!",
                  style: TextStyle(color: Colors.white, fontSize: 16, shadows: [
                    Shadow(
                        color: Color.fromARGB(25, 0, 0, 0),
                        blurRadius: 4.0,
                        offset: Offset(2, 2))
                  ]),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(flex: 6),
            ElevatedButton(
              onPressed: () {
                if (kDebugMode) {
                  print("clicked");
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Register()));
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20,
                    height: 50,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const Spacer(flex: 1),
          ],
        ))
      ],
    ));
  }
}
