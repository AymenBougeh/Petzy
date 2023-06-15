class Address {
  String name;
  String address;
  String city;
  String state;
  String zip;
  double latitude;
  double longitude;

  Address({
    this.name,
    this.address,
    this.city,
    this.state,
    this.zip,
    this.latitude,
    this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      name: json['name'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'city': city,
      'state': state,
      'zip': zip,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
