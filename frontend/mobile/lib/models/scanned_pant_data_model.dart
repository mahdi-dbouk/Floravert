import 'package:meta/meta.dart';

import 'key_facts_data_model.dart';
import 'recipe_data_model.dart';

class ScanLocation {
  String? name;
  double? lat;
  double? lng;

  ScanLocation({required this.name, required this.lat, required lng});

  ScanLocation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lat = json['lat'];
    lng = json['lng'];
  }
}

class ScannedPlant {
  KeyFacts? keyFacts;
  String? image;
  String? commonName;
  String? description;
  ScanLocation? location;
  List<Recipe>? recipes;
  List<String>? regions;
  String? id;

  ScannedPlant(
      {this.keyFacts,
      this.image,
      this.commonName,
      this.description,
      this.location,
      this.recipes,
      this.regions,
      this.id});

  ScannedPlant.fromJson(Map<String, dynamic> json) {
    keyFacts =
        json['keyFacts'] != null ? KeyFacts.fromJson(json['keyFacts']) : null;
    image = json['image'];
    commonName = json['commonName'];
    description = json['description'];
    location = json['scanLoation'] != null
        ? ScanLocation.fromJson(json['scanLocation'])
        : null;
    if (json['recipes'] != null) {
      recipes = <Recipe>[];
      json['recipes'].forEach((v) {
        recipes!.add(Recipe.fromJson(v));
      });
    }
    regions = json['regions'].cast<String>();
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (keyFacts != null) {
      data['keyFacts'] = keyFacts!.toJson();
    }
    data['image'] = image;
    data['commonName'] = commonName;
    data['description'] = description;
    if (recipes != null) {
      data['recipes'] = recipes!.map((v) => v.toJson()).toList();
    }
    data['regions'] = regions;
    data['_id'] = id;
    return data;
  }
}
