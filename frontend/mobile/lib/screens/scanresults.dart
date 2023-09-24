import 'package:flutter/material.dart';
import 'dart:io';
import '../utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class ScannedResult extends StatefulWidget {
  final File? image;
  const ScannedResult({super.key, this.image});

  @override
  State<ScannedResult> createState() => _ScannedResultState();
}

class _ScannedResultState extends State<ScannedResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
        children: [
          Stack(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  color: primary[200]),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/');
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
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16))
                            ],
                          ))
                    ],
                  ),
                  Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          border: Border.all(width: 4, color: primary)),
                      child: (widget.image == null)
                          ? Shimmer(
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
                                height: 200,
                                color: Colors.white,
                              ),
                            )
                          : Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(400)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(400),
                                child: Image.file(
                                  widget.image!,
                                  fit: BoxFit.cover,
                                ),
                              ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Common Name",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(children: [
                          const TextSpan(
                              text: "Common Name: ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "Common Plant Name",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ])),
                        Text.rich(TextSpan(children: [
                          const TextSpan(
                              text: "Botanical Name: ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "Genus species",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic)),
                        ])),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(
                      "Key Facts",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            color: primary[200],
                            child: Row(
                              children: [
                                Icon(Icons.food_bank_rounded),
                                Container(
                                  width: 180,
                                  height: 80,
                                  child: const Column(
                                    children: [
                                      Text(
                                        "Title",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("content")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            color: primary[200],
                            child: Container(
                              width: 180,
                              height: 80,
                              child: const Column(
                                children: [
                                  Text(
                                    "Title",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("content")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            color: primary[200],
                            child: Container(
                              width: 180,
                              height: 80,
                              child: const Column(
                                children: [
                                  Text(
                                    "Title",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("content")
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: primary[200],
                            child: Container(
                              width: 180,
                              height: 80,
                              child: const Column(
                                children: [
                                  Text(
                                    "Title",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("content")
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ))),
    );
  }
}
