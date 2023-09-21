import 'key_facts_data_model.dart';
import 'recipe_data_model.dart';

class ScannedPlant {
  KeyFacts? keyFacts;
  String? image;
  String? commonName;
  String? description;
  List<Recipe>? recipes;
  List<String>? regions;
  String? id;

  ScannedPlant(
      {this.keyFacts,
      this.image,
      this.commonName,
      this.description,
      this.recipes,
      this.regions,
      this.id});

  ScannedPlant.fromJson(Map<String, dynamic> json) {
    keyFacts =
        json['keyFacts'] != null ? KeyFacts.fromJson(json['keyFacts']) : null;
    image = json['image'];
    commonName = json['commonName'];
    description = json['description'];
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
