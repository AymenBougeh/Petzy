class Posts {
  String title;
  String content;
  String image;
  String dateCreated;
  int postid;
  Posts({this.title, this.content, this.image, this.dateCreated, this.postid});

  Posts.fromJson(dynamic json) {
    title = json['title'];
    content = json['content'];
    image = json['image'];
    dateCreated = json['dateCreated'];
    postid = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['dateCreated'] = this.dateCreated;
    data['user_id'] = this.postid;
    return data;
  }
}
