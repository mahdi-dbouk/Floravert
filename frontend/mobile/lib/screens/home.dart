import 'package:flutter/material.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:mobile/providers/product_provider.dart';
import 'package:mobile/providers/scanned_plant_provider.dart';
import 'package:mobile/screens/map_page.dart';
import 'package:mobile/screens/market.dart';
import 'package:mobile/widgets/custom_appbar.dart';
import 'package:mobile/screens/home_page.dart';
import 'package:mobile/widgets/map_action_button.dart';
import 'package:mobile/widgets/market_action_button.dart';
import 'package:mobile/widgets/take_photo_button.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> navigationOptions = [
    const HomePage(authUserModel: null, scannedPlantModel: null),
    const Market(),
  ];

  String page = _loadWidget(-1);

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthProvider, ScannedPlantProvider, ProductProvider>(
      builder: (context, authUserModel, scannedPlantModel, productModel,
              child) =>
          Scaffold(
              drawer: Drawer(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      DrawerHeader(
                          child: Column(
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      border: Border.all(
                                          color: Colors.yellow, width: 2)),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        authUserModel.user.pictureUrl ?? ""),
                                  ),
                                ),
                                Positioned(
                                    top: 63,
                                    left: 20,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Text(
                                        "Trader",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                authUserModel.user.username ?? "username",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 22),
                              )),
                        ],
                      )),
                      ListTile(
                        onTap: () {
                          authUserModel.becomeTrader();
                        },
                        leading: (!(authUserModel.user.isTrader ?? true))
                            ? const Icon(
                                Icons.stars_rounded,
                                color: Colors.amber,
                                size: 30,
                              )
                            : const Text(''),
                        title: (authUserModel.user.isTrader ?? false)
                            ? const Text(
                                "",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              )
                            : const Text(
                                "Become a Trader",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                      ),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                            width: 200,
                            height: 60,
                            child: ElevatedButton(
                                onPressed: () {
                                  authUserModel.logout();
                                  Navigator.of(context)
                                      .popAndPushNamed('/login');
                                },
                                child: const Text(
                                  "Logout",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ))),
                      )
                    ],
                  )),
              appBar: const CustomAppBar(),
              body: switch (page) {
                'home' => HomePage(
                    authUserModel: authUserModel,
                    scannedPlantModel: scannedPlantModel),
                'market' => const Market(),
                'map' => const MapPage(),
                String() => null,
              },
              floatingActionButton: switch (page) {
                'home' => const NavBarImageButton(),
                'market' => const MarketActionButton(),
                'map' => const MapActionButton(),
                String() => null,
              },
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                backgroundColor: Colors.white,
                items: [
                  BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(Icons.home,
                          size: 28, color: Colors.grey.shade400),
                      activeIcon: Icon(Icons.home,
                          size: 28, color: Theme.of(context).primaryColor)),
                  BottomNavigationBarItem(
                      label: 'Map',
                      icon: Icon(Icons.map,
                          size: 28, color: Colors.grey.shade400),
                      activeIcon: Icon(Icons.map,
                          size: 28, color: Theme.of(context).primaryColor)),
                  BottomNavigationBarItem(
                      label: 'Market',
                      icon: Icon(Icons.store,
                          size: 28, color: Colors.grey.shade400),
                      activeIcon: Icon(Icons.store,
                          size: 28, color: Theme.of(context).primaryColor)),
                ],
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                    page = _loadWidget(_currentIndex);
                  });
                },
              )),
    );
  }
}

String _loadWidget(int currentIndex) {
  switch (currentIndex) {
    case 0:
      return 'home';
    case 1:
      return 'map';
    case 2:
      return 'market';
    default:
      return 'home';
  }
}
