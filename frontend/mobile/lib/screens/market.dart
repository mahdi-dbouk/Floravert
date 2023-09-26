import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class Product {
  String? url;
  String? name;
  String? price;
  bool? isAvailable;
  Product({this.url, this.name, this.price, this.isAvailable});
}

class _MarketState extends State<Market> {
  final TextEditingController _searchInputController = TextEditingController();
  int _selectedOption = 0;
  List products = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  child: TextField(
                    controller: _searchInputController,
                    decoration: InputDecoration(
                      hintText: "Search",
                      labelText: "Search",
                      hintStyle: const TextStyle(color: Colors.black38),
                      prefixIcon: Icon(Icons.search,
                          color: Theme.of(context).colorScheme.primary),
                      filled: true,
                      fillColor: Colors.grey[100],
                      focusColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade400, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: IconButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.primary)),
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      )),
                )
              ],
            ),
          ),
        ),
        const Center(
          child: Text(
            "Categories",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 100,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  tileColor:
                      (_selectedOption == 0) ? Colors.green[100] : Colors.white,
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.spa_rounded),
                      SizedBox(width: 2),
                      Text('Natural'),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _selectedOption = 0;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 100,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  tileColor:
                      (_selectedOption == 1) ? Colors.green[100] : Colors.white,
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.spa_rounded),
                      SizedBox(width: 2),
                      Text('Processed'),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _selectedOption = 1;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
