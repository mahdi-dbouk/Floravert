import 'post_data_model.dart';
import 'scanned_pant_data_model.dart';
import 'message_data_model.dart';
import 'contact_data_model.dart';
import 'product_data_model.dart';

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  int? age;
  String? phone;
  String? pictureUrl;
  bool? isTrader;
  List<Post>? posts;
  List<ScannedPlant>? scannedPlants;
  List<Message>? messages;
  List<String>? followers;
  List<String>? followed;
  List<Contact>? contacts;
  List<Product>? products;

  User(
      {this.id,
      this.firstName,
      this.lastName,
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
    email = json['email'];
    age = json['age'];
    phone = json['phone'];
    pictureUrl = json['picture_url'];
    isTrader = json['isTrader'];
    if (json['posts'] != null) {
      posts = <Post>[];
      json['posts'].forEach((v) {
        posts!.add(new Post.fromJson(v));
      });
    }
    if (json['scannedPlants'] != null) {
      scannedPlants = <ScannedPlant>[];
      json['scannedPlants'].forEach((v) {
        scannedPlants!.add(new ScannedPlant.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      messages = <Message>[];
      json['messages'].forEach((v) {
        messages!.add(new Message.fromJson(v));
      });
    }
    followers = json['followers'].cast<String>();
    followed = json['followed'].cast<String>();
    if (json['contacts'] != null) {
      contacts = <Contact>[];
      json['contacts'].forEach((v) {
        contacts!.add(new Contact.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['age'] = this.age;
    data['phone'] = this.phone;
    data['picture_url'] = this.pictureUrl;
    data['isTrader'] = this.isTrader;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    if (this.scannedPlants != null) {
      data['scannedPlants'] =
          this.scannedPlants!.map((v) => v.toJson()).toList();
    }
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    data['followers'] = this.followers;
    data['followed'] = this.followed;
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
