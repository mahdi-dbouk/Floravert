import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

void initializeSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isStarted', true);
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/floravert_logo.png',
                  scale: 3,
                )
              ],
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
                initializeSharedPreferences();
                Navigator.of(context).pushReplacementNamed('/register');
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
