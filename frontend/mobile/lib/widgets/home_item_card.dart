import 'package:flutter/material.dart';
import 'package:mobile/models/scanned_pant_data_model.dart';
import 'package:shimmer/shimmer.dart';

class HomeItemCard extends StatefulWidget {
  final String commonName;
  final String? url;
  final ScannedPlant item;
  const HomeItemCard(
      {super.key,
      required this.commonName,
      required this.url,
      required this.item});

  @override
  State<HomeItemCard> createState() => _HomeItemCardState();
}

class _HomeItemCardState extends State<HomeItemCard> {
  bool imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.url ??
                      "https://raw.githubusercontent.com/julien-gargot/images-placeholder/master/placeholder-square.png",
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress != null) {
                      return Shimmer(
                        gradient: LinearGradient(
                            colors: [
                              Colors.grey[300]!,
                              Colors.grey[300]!,
                              Colors.grey[300]!,
                              Colors.grey[300]!,
                              Colors.grey[300]!,
                              Colors.grey[100]!,
                              Colors.grey[300]!,
                              Colors.grey[300]!,
                              Colors.grey[300]!,
                              Colors.grey[300]!,
                              Colors.grey[300]!,
                            ],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight),
                        period: const Duration(milliseconds: 1500),
                        direction: ShimmerDirection.ltr,
                        child: Container(
                          width: 200,
                          height: 256,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return child;
                    }
                  },
                ),
              ),
            ),
          ),
          Text.rich(TextSpan(
              children: [
                TextSpan(text: widget.commonName),
              ],
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
          const Text.rich(TextSpan(children: [
            TextSpan(text: 'example name'),
          ], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
