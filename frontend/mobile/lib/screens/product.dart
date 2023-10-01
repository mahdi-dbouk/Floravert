import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../screens/chat.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int activeIndex = 0;
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    final Map<String, dynamic>? args = arguments as Map<String, dynamic>?;
    final String description = args?['product'].description;
    final double price = args?['product'].price;

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
                                    offset: const Offset(0, 2))
                              ]),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          padding: EdgeInsets.zero,
                          child: Image.network(
                            image ?? "https://i.stack.imgur.com/y9DpT.jpg",
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
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: const Offset(0, 2))
              ]),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      args?['product'].name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Text('\$$price / Kg',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                    child: Text(
                  "Select the quantity in (Kg)",
                  style: TextStyle(color: Colors.grey),
                )),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity--;
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.primary)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.primary)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Description",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '$description',
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        )),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 180,
            padding: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                        color: Theme.of(context).colorScheme.primary))),
            child: Column(
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ListTile(
                      title: Text(
                        args!['product'].traderName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                          "Want to order? You can do so by contacting me."),
                      leading: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2)),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              args['product'].profilePic ??
                                  "https://i.stack.imgur.com/y9DpT.jpg",
                              scale: 1),
                        ),
                      ),
                    ))
                  ],
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text("Send Order Message")),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Chats(
                                      key: UniqueKey(),
                                      username: args['product'].traderName,
                                      traderEmail: args['product'].traderEmail,
                                      profilePic: args['product'].profilePic,
                                    )),
                          );
                        },
                        child: const Text("Custom Message"))
                  ],
                ))
              ],
            ))
      ],
    )));
  }
}
