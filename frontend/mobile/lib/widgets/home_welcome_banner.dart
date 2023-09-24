import 'package:flutter/material.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 1)),
              child: const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://cdn3d.iconscout.com/3d/premium/thumb/hrd-manager-9642497-7825761.png?f=webp'),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(text: "Hello, ", style: TextStyle(fontSize: 18)),
              TextSpan(
                  text: "Mike",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
              TextSpan(
                  text: "!",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600))
            ])),
          ],
        ),
      ),
    );
  }
}
