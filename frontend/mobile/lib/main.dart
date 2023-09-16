import 'package:flutter/material.dart';
import 'utils/colors.dart';
import 'landing.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Floravert",
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: primary,
              backgroundColor: background,
            )),
        home: const Landing());
  }
}
