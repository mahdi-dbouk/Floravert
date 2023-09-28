import 'package:flutter/material.dart';
import 'package:mobile/providers/product_provider.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (BuildContext context, productModel, child) {
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                    width: 100,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      tileColor: (_selectedOption == 0)
                          ? Colors.green[100]
                          : Colors.white,
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
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: SizedBox(
                    width: 100,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      tileColor: (_selectedOption == 1)
                          ? Colors.green[100]
                          : Colors.white,
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
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: productModel.products.length,
                itemBuilder: (context, index) => Container(
                  height: 120,
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black26))),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/product', arguments: {
                          "product": productModel.products[index]
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                productModel
                                                    .products[index].images![0],
                                                scale: 1),
                                            fit: BoxFit.cover,
                                            scale: 1)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      productModel.products[index].name!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      '\$${productModel.products[index].price!}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(),
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
