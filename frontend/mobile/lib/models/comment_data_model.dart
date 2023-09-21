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
        replies!.add(new Reply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['content'] = this.content;
    data['_id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
