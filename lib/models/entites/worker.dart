class Worker {
  String name;
  String phone;
  String image;
  String licenseNumber;
  String status;
  int yearsOfExperience;
  String description;
  String role;
  double latitude;
  double longitude;
  int price;
  String services;
  String aboutPet;
  int workerId;

  Worker({
    this.name,
    this.phone,
    this.image,
    this.licenseNumber,
    this.yearsOfExperience,
    this.description,
    this.role,
    this.latitude,
    this.longitude,
    this.price,
    this.services,
    this.aboutPet,
    this.workerId,
  });

  Worker.fromJson(dynamic json) {
    name = json["name"];
    phone = json["phone"];
    image = json["image"];
    licenseNumber = json["license_number"];
    yearsOfExperience = json["years_of_experience"];
    description = json["description"];
    role = json["role"];

    try {
      latitude = double.parse(json["latitude"].toString());
    } catch (e) {
      latitude = 0.0; // Set a default value or handle the error as needed
    }

    try {
      longitude = double.parse(json["longitude"].toString());
    } catch (e) {
      longitude = 0.0; // Set a default value or handle the error as needed
    }

    price = json["price"];
    services = json["services"];
    aboutPet = json["aboutPet"];
    workerId = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['license_number'] = this.licenseNumber;
    data['years_of_experience'] = this.yearsOfExperience;
    data['description'] = this.description;
    data['role'] = this.role;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['price'] = this.price;
    data['services'] = this.services;
    data['aboutPet'] = this.aboutPet;
    data['id'] = this.workerId;
    return data;
  }
}
