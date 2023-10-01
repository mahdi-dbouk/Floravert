class Product {
  String? traderName;
  String? traderEmail;
  String? profilePic;
  String? phone;
  String? name;
  String? category;
  List<int>? ratings;
  double? price;
  List<String>? images;
  String? description;
  double? totalQuantity;

  Product(
      {this.name,
      this.category,
      this.ratings,
      this.price,
      this.images,
      this.description,
      this.totalQuantity});

  Product.fromJson(Map<String, dynamic> json) {
    traderName = json['traderName'] ?? '';
    traderEmail = json['email'] ?? '';
    phone = json['phone'] ?? '';
    name = json['product']['name'] ?? '';
    profilePic = json['traderProfilePic'] ?? '';
    category = json['product']['category'] ?? '';
    price = json['product']['price'] ?? 0.0;
    ratings = (json['product']['ratings'] as List<dynamic>?)?.cast<int>() ?? [];
    images =
        (json['product']['images'] as List<dynamic>?)?.cast<String>() ?? [];
    description = json['product']['description'] ?? '';
    //totalQuantity = json['product']['totalQuantity'] ?? 0.0;
  }
  Product.fromJson2(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    category = json['category'] ?? '';
    price = json['price'] ?? 0.0;
    ratings = (json['ratings'] as List<dynamic>?)?.cast<int>() ?? [];
    images = (json['images'] as List<dynamic>?)?.cast<String>() ?? [];
    description = json['description'] ?? '';
    //totalQuantity = json['product']['totalQuantity'] ?? 0.0;
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
