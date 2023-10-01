import 'package:flutter/material.dart';

class WelcomeBanner extends StatefulWidget {
  final String? name;
  final String? url;
  const WelcomeBanner({super.key, required this.name, required this.url});

  @override
  State<WelcomeBanner> createState() => _WelcomeBannerState();
}

class _WelcomeBannerState extends State<WelcomeBanner> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(text: "Hello, ", style: TextStyle(fontSize: 22)),
              TextSpan(
                  text: widget.name,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600)),
              TextSpan(
                  text: "!",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600))
            ])),
          ],
        ),
      ),
    );
  }
}
