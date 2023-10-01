import 'package:flutter/material.dart';
import 'package:mobile/models/scanned_pant_data_model.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:mobile/providers/scanned_plant_provider.dart';
import 'package:mobile/widgets/home_welcome_banner.dart';
import 'package:mobile/widgets/horizontal_scrollable_widget_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final AuthProvider? authUserModel;
  final ScannedPlantProvider? scannedPlantModel;
  const HomePage(
      {super.key,
      required this.authUserModel,
      required this.scannedPlantModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ScannedPlantProvider>(context, listen: false).setScannedPlants(
        List<ScannedPlant>.from(
            widget.authUserModel?.user.scannedPlants ?? []));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeBanner(
                name: widget.authUserModel?.user.firstName,
                url: widget.authUserModel?.user.pictureUrl ?? ""),
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
            HorizontallyScrollableSection(
                scannedPlantModel: widget.scannedPlantModel),
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
            HorizontallyScrollableSection(
                scannedPlantModel: widget.scannedPlantModel!),
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
            HorizontallyScrollableSection(
                scannedPlantModel: widget.scannedPlantModel!),
          ],
        ),
      ),
    );
  }
}
