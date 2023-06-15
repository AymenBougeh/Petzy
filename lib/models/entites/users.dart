class Users {
  String name;
  String email;
  String phone;
  String image;
  int userId;

  Users({
    this.name,
    this.phone,
    this.image,
    this.email,
    this.userId,
  });

  Users.fromJson(dynamic json) {
    name = json["name"];
    phone = json["phone"];
    image = json["image"];
    email = json["email"];
    userId = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['email'] = this.email;
    data['id'] = this.userId;
    return data;
  }
}
