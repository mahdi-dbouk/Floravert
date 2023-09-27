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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 3)),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.url ??
                    'https://cdn3d.iconscout.com/3d/premium/thumb/hrd-manager-9642497-7825761.png?f=webp'),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(text: "Hello, ", style: TextStyle(fontSize: 18)),
              TextSpan(
                  text: widget.name,
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
