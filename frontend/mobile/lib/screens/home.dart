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
      builder:
          (context, authUserModel, scannedPlantModel, productModel, child) =>
              Scaffold(
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
                    'map' => const NavBarImageButton(),
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
