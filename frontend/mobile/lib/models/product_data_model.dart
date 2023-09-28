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
    traderName = json['traderName'];
    traderEmail = json['email'];
    phone = json['phone'];
    name = json['product']['name'];
    profilePic = json['traderProfilePic'];
    category = json['product']['category'];
    price = json['product']['price'];
    ratings = json['product']['ratings'].cast<int>() ?? [];
    images = json['product']['images'].cast<String>() ?? [];
    description = json['product']['description'];
    totalQuantity = json['product']['totalQuantity'];
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
