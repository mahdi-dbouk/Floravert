import 'package:flutter/material.dart';
import 'package:mobile/models/scanned_pant_data_model.dart';
import 'package:mobile/widgets/home_item_card.dart';

class HorizontallyScrollableSection extends StatefulWidget {
  final List<ScannedPlant> items;
  const HorizontallyScrollableSection({super.key, required this.items});

  @override
  State<HorizontallyScrollableSection> createState() =>
      _HorizontallyScrollableSectionState();
}

class _HorizontallyScrollableSectionState
    extends State<HorizontallyScrollableSection> {
  bool dataFound = false;
  @override
  void initState() {
    super.initState();
    if (widget.items.isEmpty) {
      dataFound = false;
    } else {
      dataFound = true;
    }
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
                  itemCount: widget.items.length,
                  separatorBuilder: (context, _) => const SizedBox(
                    width: 14,
                  ),
                  itemBuilder: (context, index) => HomeItemCard(
                    item: widget.items[index],
                    commonName: widget.items[index].commonName!,
                    url: widget.items[index].image!,
                  ),
                )
              : Center(child: Text("Nothing here yet :("))),
    );
  }
}
