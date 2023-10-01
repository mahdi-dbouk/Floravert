import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:mobile/providers/scanned_plant_provider.dart';
import 'package:mobile/widgets/home_item_card.dart';

class HorizontallyScrollableSection extends StatefulWidget {
  final ScannedPlantProvider? scannedPlantModel;
  final AuthProvider? authUserModel;
  final bool? isFromMap;
  const HorizontallyScrollableSection(
      {super.key,
      required this.scannedPlantModel,
      this.isFromMap,
      this.authUserModel});

  @override
  State<HorizontallyScrollableSection> createState() =>
      _HorizontallyScrollableSectionState();
}

class _HorizontallyScrollableSectionState
    extends State<HorizontallyScrollableSection> {
  bool dataFound = false;
  @override
  void initState() {
    if (widget.scannedPlantModel!.scannedPlants.isEmpty) {
      dataFound = false;
    } else {
      dataFound = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: (dataFound)
              ? ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.scannedPlantModel!.scannedPlants.length,
                  separatorBuilder: (context, _) => const SizedBox(
                    width: 14,
                  ),
                  itemBuilder: (context, index) => HomeItemCard(
                    isFromMap: widget.isFromMap,
                    item: widget.scannedPlantModel!.scannedPlants[index],
                    commonName: widget
                        .scannedPlantModel!.scannedPlants[index].commonName!,
                    url: widget.scannedPlantModel!.scannedPlants[index].image!,
                  ),
                )
              : const Center(child: Text("Nothing here yet :("))),
    );
  }
}
