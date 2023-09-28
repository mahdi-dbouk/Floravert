import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    final Map<String, dynamic>? args = arguments as Map<String, dynamic>?;

    return Scaffold(
        body: SafeArea(
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
                  Navigator.of(context).pop();
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
        (args?['product'].images.length != 0)
            ? Column(
                children: [
                  CarouselSlider.builder(
                      itemCount: args?['product'].images.length,
                      itemBuilder: (context, index, realIndex) {
                        final String image = args?['product'].images[index];
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 2))
                              ]),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          padding: EdgeInsets.zero,
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      options: CarouselOptions(
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                        height: 200,
                        aspectRatio: 1 / 1,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                            print(activeIndex);
                          });
                        },
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  AnimatedSmoothIndicator(
                      effect: WormEffect(
                          activeDotColor: Theme.of(context).colorScheme.primary,
                          dotHeight: 10,
                          dotWidth: 10),
                      activeIndex: activeIndex,
                      count: args?['product'].images.length)
                ],
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                padding: EdgeInsets.zero,
                child: Image.asset(
                  './assets/placeholder-square.png',
                  fit: BoxFit.cover,
                )),
        const SizedBox(
          height: 20,
        ),
        Expanded(child: Container()),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            padding: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                        color: Theme.of(context).colorScheme.primary))),
            child: ListTile(
              title: Text(args!['product'].traderName),
              trailing:
                  ElevatedButton(onPressed: () {}, child: Text('Order Now')),
              leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2)),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      NetworkImage(args?['product'].profilePic, scale: 1),
                ),
              ),
            ))
      ],
    )));
  }
}
