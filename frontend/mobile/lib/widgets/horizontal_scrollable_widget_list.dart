import 'package:flutter/material.dart';
import 'package:mobile/models/scanned_pant_data_model.dart';
import 'package:mobile/providers/scanned_plant_provider.dart';
import 'package:mobile/widgets/home_item_card.dart';

class HorizontallyScrollableSection extends StatefulWidget {
  final ScannedPlantProvider scannedPlantModel;
  const HorizontallyScrollableSection(
      {super.key, required this.scannedPlantModel});

  @override
  State<HorizontallyScrollableSection> createState() =>
      _HorizontallyScrollableSectionState();
}

class _HorizontallyScrollableSectionState
    extends State<HorizontallyScrollableSection> {
  bool dataFound = false;
  @override
  void initState() {
    if (widget.scannedPlantModel.scannedPlants.isEmpty) {
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
                  itemCount: widget.scannedPlantModel.scannedPlants.length,
                  separatorBuilder: (context, _) => const SizedBox(
                    width: 14,
                  ),
                  itemBuilder: (context, index) => HomeItemCard(
                    item: widget.scannedPlantModel.scannedPlants[index],
                    commonName: widget
                        .scannedPlantModel.scannedPlants[index].commonName!,
                    url: widget.scannedPlantModel.scannedPlants[index].image!,
                  ),
                )
              : Center(child: Text("Nothing here yet :("))),
    );
  }
}
