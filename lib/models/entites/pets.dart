class Pets {
  String name;
  String species;
  String breed;
  String image;
  int userId;
  int petId;
  int age;

  Pets(
      {this.name,
      this.species,
      this.image,
      this.breed,
      this.userId,
      this.petId,
      this.age});

  Pets.fromJson(dynamic json) {
    name = json['name'];
    species = json['species'];
    image = json['image'];
    breed = json['breed'];
    userId = json['user_id'];
    petId = json['id'];
    age = json[age];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['species'] = this.species;
    data['image'] = this.image;
    data['breed'] = this.breed;
    data['user_id'] = this.userId;
    data['id'] = this.petId;
    data['age'] = this.age;
    return data;
  }
}
