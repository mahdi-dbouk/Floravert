class Reply {
  String? user;
  String? content;
  String? id;

  Reply({this.user, this.content, this.id});

  Reply.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    content = json['content'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user'] = user;
    data['content'] = content;
    data['_id'] = id;
    return data;
  }
}
