import 'post_data_model.dart';
import 'scanned_pant_data_model.dart';
import 'message_data_model.dart';
import 'contact_data_model.dart';
import 'product_data_model.dart';

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  int? age;
  String? phone;
  String? pictureUrl;
  bool? isTrader;
  List<Post>? posts;
  List<ScannedPlant>? scannedPlants;
  List<MessageModel>? messages;
  List<String>? followers;
  List<String>? followed;
  List<Contact>? contacts;
  List<Product>? products;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.age,
      this.phone,
      this.pictureUrl,
      this.isTrader,
      this.posts,
      this.scannedPlants,
      this.messages,
      this.followers,
      this.followed,
      this.contacts,
      this.products});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    email = json['email'];
    age = json['age'];
    phone = json['phone'];
    pictureUrl = json['picture_url'];
    isTrader = json['isTrader'];
    if (json['posts'] != null) {
      posts = <Post>[];
      json['posts'].forEach((v) {
        posts!.add(Post.fromJson(v));
      });
    }
    if (json['scannedPlants'] != null) {
      scannedPlants = <ScannedPlant>[];
      json['scannedPlants'].forEach((v) {
        scannedPlants!.add(ScannedPlant.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      messages = <MessageModel>[];
      json['messages'].forEach((v) {
        messages!.add(MessageModel.fromJson(v));
      });
    }
    followers =
        (json['followers'] != null) ? json['followers'].cast<String>() : [];
    followed =
        (json['followed'] != null) ? json['followed'].cast<String>() : [];
    if (json['contacts'] != null) {
      contacts = <Contact>[];
      json['contacts'].forEach((v) {
        contacts!.add(Contact.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['age'] = age;
    data['phone'] = phone;
    data['picture_url'] = pictureUrl;
    data['isTrader'] = isTrader;
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    if (scannedPlants != null) {
      data['scannedPlants'] = scannedPlants!.map((v) => v.toJson()).toList();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    data['followers'] = followers;
    data['followed'] = followed;
    if (contacts != null) {
      data['contacts'] = contacts!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
