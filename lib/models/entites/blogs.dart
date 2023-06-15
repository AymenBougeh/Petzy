class Blogs {
  String title;
  String content;
  int userId;
  String image;

  Blogs({this.title, this.content, this.image, this.userId});

  Blogs.fromJson(dynamic json) {
    title = json['title'];
    content = json['content'];
    image = json['image'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['userId'] = this.userId;
    return data;
  }
}
