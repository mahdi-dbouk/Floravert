class Recipe {
  List<String>? ingredients;
  String? id;
  String? name;
  String? category;

  Recipe({this.ingredients, this.id, this.name, this.category});

  Recipe.fromJson(Map<String, dynamic> json) {
    ingredients = json['ingredients'].cast<String>();
    id = json['_id'];
    name = json['name'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ingredients'] = ingredients;
    data['_id'] = id;
    data['name'] = name;
    data['category'] = category;
    return data;
  }
}
