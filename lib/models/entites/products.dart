class Products {
  int id;
  String name;
  String description;
  String image;
  int price;
  String breed;

  Products(
      {this.name,
      this.description,
      this.image,
      this.price,
      this.id,
      this.breed});

  Products.fromJson(dynamic json) {
    id = json['id'];

    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    breed = json['breed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['breed'] = this.breed;
    return data;
  }
}
