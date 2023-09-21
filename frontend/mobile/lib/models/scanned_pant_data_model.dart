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
    keyFacts = json['keyFacts'] != null
        ? new KeyFacts.fromJson(json['keyFacts'])
        : null;
    image = json['image'];
    commonName = json['commonName'];
    description = json['description'];
    if (json['recipes'] != null) {
      recipes = <Recipe>[];
      json['recipes'].forEach((v) {
        recipes!.add(new Recipe.fromJson(v));
      });
    }
    regions = json['regions'].cast<String>();
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.keyFacts != null) {
      data['keyFacts'] = this.keyFacts!.toJson();
    }
    data['image'] = this.image;
    data['commonName'] = this.commonName;
    data['description'] = this.description;
    if (this.recipes != null) {
      data['recipes'] = this.recipes!.map((v) => v.toJson()).toList();
    }
    data['regions'] = this.regions;
    data['_id'] = this.id;
    return data;
  }
}
