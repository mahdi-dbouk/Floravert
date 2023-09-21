import 'reply_data_model.dart';

class Comment {
  String? user;
  String? content;
  String? id;
  String? createdAt;
  String? updatedAt;
  List<Reply>? replies;

  Comment(
      {this.user,
      this.content,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.replies});

  Comment.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    content = json['content'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['replies'] != null) {
      replies = <Reply>[];
      json['replies'].forEach((v) {
        replies!.add(Reply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user'] = user;
    data['content'] = content;
    data['_id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
