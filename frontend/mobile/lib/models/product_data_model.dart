class Product {
  String? name;
  String? category;
  List<int>? ratings;
  double? price;
  List<String>? images;
  String? description;
  int? totalQuantity;

  Product(
      {this.name,
      this.category,
      this.ratings,
      this.price,
      this.images,
      this.description,
      this.totalQuantity});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    price = json['price'];
    ratings = json['ratings'].cast<int>();
    images = json['images'].cast<String>();
    description = json['description'];
    totalQuantity = json['totalQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['category'] = category;
    data['price'] = price;
    data['ratings'] = ratings;
    data['images'] = images;
    data['description'] = description;
    data['totalQuantity'] = totalQuantity;
    return data;
  }
}
