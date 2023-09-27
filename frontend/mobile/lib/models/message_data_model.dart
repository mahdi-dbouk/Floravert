class MessageModel {
  String? sender;
  String? content;
  String? createdAt;
  String? updatedAt;

  MessageModel({this.sender, this.content, this.createdAt, this.updatedAt});

  MessageModel.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['sender'] = sender;
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
