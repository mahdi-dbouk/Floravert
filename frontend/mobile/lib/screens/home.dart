import 'package:flutter/material.dart';
import 'package:mobile/models/scanned_pant_data_model.dart';
import 'package:mobile/widgets/custom_appbar.dart';
import 'package:mobile/widgets/custom_bottom_navigator.dart';
import 'package:mobile/widgets/home_welcome_banner.dart';
import 'package:mobile/widgets/horizontal_scrollable_widget_list.dart';
import 'package:mobile/widgets/take_photo_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ScannedPlant> items = [
    ScannedPlant(
        commonName: "Grape Tree",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/4/4d/Grape_plant_2.jpg"),
    ScannedPlant(
        commonName: "Ranakalli Plant",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/d/d1/Ranakalli_plant.jpg"),
    ScannedPlant(
      commonName: "Butterfly-pea Plant",
      image:
          "https://upload.wikimedia.org/wikipedia/commons/f/fa/Clitoria_ternatea_plants_15042014.jpg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WelcomeBanner(),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Popular Plants",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                HorizontallyScrollableSection(items: items),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Recently Scanned",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                HorizontallyScrollableSection(items: items),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Favorites",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                HorizontallyScrollableSection(items: items),
              ],
            ),
          ),
        ),
        floatingActionButton: const NavBarImageButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomBottomNavigator());
  }
}
