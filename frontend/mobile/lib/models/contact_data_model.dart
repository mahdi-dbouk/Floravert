class Contact {
  String? user;
  String? id;
  String? createdAt;
  String? updatedAt;

  Contact({this.user, this.id, this.createdAt, this.updatedAt});

  Contact.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user'] = user;
    data['_id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
