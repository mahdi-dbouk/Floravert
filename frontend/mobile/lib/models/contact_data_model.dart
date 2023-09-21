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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['_id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
