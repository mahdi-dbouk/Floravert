import 'package:flutter/material.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:mobile/providers/scanned_plant_provider.dart';
import 'package:mobile/screens/market.dart';
import 'package:mobile/widgets/custom_appbar.dart';
import 'package:mobile/screens/home_page.dart';
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
    return Consumer2<AuthProvider, ScannedPlantProvider>(
      builder: (context, authUserModel, scannedPlantModel, child) => Scaffold(
          drawer: Drawer(
              backgroundColor: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  DrawerHeader(
                      child: Column(
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              border:
                                  Border.all(color: Colors.yellow, width: 2)),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                authUserModel.user.pictureUrl ?? ""),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            authUserModel.user.username ?? "username",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          )),
                    ],
                  )),
                  const ListTile(
                    leading: Icon(
                      Icons.stars_rounded,
                      color: Colors.amber,
                      size: 30,
                    ),
                    title: Text(
                      "Become a Trader",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                        width: 200,
                        height: 60,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
            String() => null,
          },
          floatingActionButton: const NavBarImageButton(),
/*           floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked, */
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home, size: 28, color: Colors.grey.shade400),
                  activeIcon: Icon(Icons.home,
                      size: 28, color: Theme.of(context).primaryColor)),
              BottomNavigationBarItem(
                  label: 'Map',
                  icon: Icon(Icons.map, size: 28, color: Colors.grey.shade400),
                  activeIcon: Icon(Icons.map,
                      size: 28, color: Theme.of(context).primaryColor)),
              BottomNavigationBarItem(
                  label: 'Market',
                  icon:
                      Icon(Icons.store, size: 28, color: Colors.grey.shade400),
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
