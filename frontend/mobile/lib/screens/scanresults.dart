import 'package:flutter/material.dart';
import 'package:mobile/models/scanned_pant_data_model.dart';
import 'package:mobile/providers/scanned_plant_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class ScannedResult extends StatefulWidget {
  final File? image;
  final ScannedPlant? scannedPlant;
  final bool isAScan;
  const ScannedResult(
      {super.key, this.image, required this.isAScan, this.scannedPlant});

  @override
  State<ScannedResult> createState() => _ScannedResultState();
}

class _ScannedResultState extends State<ScannedResult> {
  @override
  void initState() {
    super.initState();
    if (widget.isAScan) {
      Provider.of<ScannedPlantProvider>(context, listen: false)
          .sendScannedPhotoToServer(widget.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScannedPlantProvider>(
      builder: (BuildContext context, scannedPlantModel, Widget? child) =>
          Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
          children: [
            Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    color: primary[200]),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: Colors.black87,
                                  size: 32.0,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("back",
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 16))
                              ],
                            )),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.share_location_rounded,
                                  color: Colors.black87,
                                  size: 32,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.share_sharp,
                                  color: Colors.black87,
                                  size: 28,
                                )),
                          ],
                        )
                      ],
                    ),
                    Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            border: Border.all(width: 4, color: primary)),
                        child: (widget.image == null)
                            ? Shimmer(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.grey[300]!,
                                      Colors.grey[300]!,
                                      Colors.grey[300]!,
                                      Colors.grey[300]!,
                                      Colors.grey[300]!,
                                      Colors.grey[100]!,
                                      Colors.grey[300]!,
                                      Colors.grey[300]!,
                                      Colors.grey[300]!,
                                      Colors.grey[300]!,
                                      Colors.grey[300]!,
                                    ],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight),
                                period: const Duration(milliseconds: 1500),
                                direction: ShimmerDirection.ltr,
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  color: Colors.white,
                                ),
                              )
                            : Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(400)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(400),
                                  child: (widget.isAScan)
                                      ? Image.file(
                                          widget.image!,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          widget.scannedPlant!.image!,
                                          fit: BoxFit.cover,
                                        ),
                                ))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        (widget.isAScan)
                            ? scannedPlantModel.result.commonName!
                            : widget.scannedPlant!.commonName!,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 36,
                        child: Center(
                          child: Text(
                            (widget.isAScan)
                                ? scannedPlantModel.result.botanicalName!
                                : widget.scannedPlant!.botanicalName!,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        "Key Facts",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              color: primary[200],
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: 180,
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.food_bank_rounded,
                                      size: 36,
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    SizedBox(
                                      height: 80,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Edibility",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          (widget.isAScan)
                                              ? Text(scannedPlantModel
                                                  .result.keyFacts!.edibility!)
                                              : Text(widget.scannedPlant!
                                                      .keyFacts!.edibility ??
                                                  "")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: primary[200],
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: 180,
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.emergency_outlined,
                                      size: 36,
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    SizedBox(
                                      height: 80,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Toxicity",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          (widget.isAScan)
                                              ? Text(scannedPlantModel
                                                  .result.keyFacts!.toxicity!)
                                              : Text(widget.scannedPlant!
                                                      .keyFacts!.toxicity ??
                                                  "")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              color: primary[200],
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: 180,
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.forest,
                                      size: 36,
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    SizedBox(
                                      height: 80,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Habitat",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          (widget.isAScan)
                                              ? Text(scannedPlantModel
                                                  .result.keyFacts!.habitat!)
                                              : Text(widget.scannedPlant!
                                                      .keyFacts!.habitat ??
                                                  "")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: primary[200],
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: 180,
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.emoji_food_beverage_rounded,
                                      size: 36,
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    SizedBox(
                                      height: 80,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Use",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          (widget.isAScan)
                                              ? Text(scannedPlantModel
                                                  .result.keyFacts!.use!)
                                              : Text(widget.scannedPlant!
                                                      .keyFacts!.use ??
                                                  "")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              color: primary[200],
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: 180,
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.severe_cold_rounded,
                                      size: 36,
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    SizedBox(
                                      height: 80,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Seasonality",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          (widget.isAScan)
                                              ? Text(scannedPlantModel.result
                                                  .keyFacts!.seasonality!)
                                              : Text(widget.scannedPlant!
                                                      .keyFacts!.seasonality ??
                                                  "")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: primary[200],
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: 180,
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      size: 36,
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    SizedBox(
                                      height: 80,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Status",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          (widget.isAScan)
                                              ? Text(scannedPlantModel
                                                  .result
                                                  .keyFacts!
                                                  .conservationStatus!)
                                              : Text(widget
                                                      .scannedPlant!
                                                      .keyFacts!
                                                      .conservationStatus ??
                                                  "")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(fontSize: 18),
                            text: (widget.isAScan)
                                ? scannedPlantModel.result.description
                                : widget.scannedPlant!.description!,
                          ),
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.justify,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        "Recipes",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: primary[200],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ListTile(
                                    title: (widget.isAScan)
                                        ? Center(
                                            child: Text(scannedPlantModel
                                                .result.recipes![index].name!),
                                          )
                                        : Center(
                                            child: Text((widget.scannedPlant!
                                                .recipes![index].name!)),
                                          ),
                                    subtitle: (widget.isAScan)
                                        ? Center(
                                            child: Text(scannedPlantModel.result
                                                .recipes![index].ingredients!),
                                          )
                                        : Center(
                                            child: Text(widget.scannedPlant!
                                                .recipes![index].ingredients!),
                                          ),
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: (widget.isAScan)
                              ? scannedPlantModel.result.recipes!.length
                              : widget.scannedPlant!.recipes!.length),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        "Regions",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => ListTile(
                                title: (widget.isAScan)
                                    ? Center(
                                        child: Text(
                                          scannedPlantModel
                                              .result.regions![index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          widget.scannedPlant!.regions![index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: (widget.isAScan)
                              ? scannedPlantModel.result.regions!.length
                              : widget.scannedPlant!.regions!.length),
                    )
                  ],
                )
              ],
            ),
          ],
        ))),
      ),
    );
  }
}
