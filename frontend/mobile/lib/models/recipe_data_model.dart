class Recipe {
  String? ingredients;
  String? name;

  Recipe({this.ingredients, this.name});

  Recipe.fromJson(Map<String, dynamic> json) {
    ingredients = json['ingredients'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ingredients'] = ingredients;
    data['name'] = name;
    return data;
  }
}
