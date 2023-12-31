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
  Map<String, dynamic> toJson() {
    return {'name': name, 'lat': lat, 'lng': lng};
  }
}

class ScannedPlant {
  KeyFacts? keyFacts;
  String? image;
  String? commonName;
  String? botanicalName;
  String? description;
  ScanLocation? location;
  List<Recipe>? recipes;
  List<String>? regions;
  String? id;

  ScannedPlant(
      {this.keyFacts,
      this.image,
      this.commonName,
      this.botanicalName,
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
    botanicalName = json['botanicalName'];
    description = json['description'];
    location = json['scanLocation'] != null
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

  ScannedPlant.fromJson2(Map<String, dynamic> json) {
    keyFacts = KeyFacts.fromJson(json['result']['keyFacts']);
    image = json['image'];
    commonName = json['result']['commonName'];
    botanicalName = json['result']['botanicalName'];
    description = json['result']['description'];
    if (json['result']['recipes'] != null) {
      recipes = <Recipe>[];
      json['result']['recipes'].forEach((v) {
        recipes!.add(Recipe.fromJson(v));
      });
    }
    regions = List<String>.from(json['result']['regions']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (keyFacts != null) {
      data['keyFacts'] = keyFacts!.toJson();
    }
    data['imageURL'] = image;
    data['commonName'] = commonName;
    data['botanicalName'] = botanicalName;
    data['description'] = description;
    if (recipes != null) {
      data['recipes'] = recipes!.map((v) => v.toJson()).toList();
    }
    //data['scanLocation'] = location!.toJson();
    data['regions'] = regions;
    data['_id'] = id;
    return data;
  }
}
