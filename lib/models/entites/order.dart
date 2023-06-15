class Order {
  int id;
  int userId;
  String status;
  String workerName;
  String petName;
  DateTime pickUpDate;
  DateTime dropOffDate;
  int walkPerDay;
  int mealPerDay;
  int workerId;
  int price;

  Order({
    this.id,
    this.userId,
    this.status,
    this.workerName,
    this.petName,
    this.pickUpDate,
    this.dropOffDate,
    this.walkPerDay,
    this.mealPerDay,
    this.workerId,
    this.price,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    try {
      return Order(
        id: json['id'],
        userId: json['user_id'],
        status: json['status'],
        workerName: json['worker_name'],
        petName: json['pet_name'],
        pickUpDate: json['pick_up_date'] != null
            ? DateTime.parse(json['pick_up_date'])
            : null,
        dropOffDate: json['drop_of_date'] != null
            ? DateTime.parse(json['drop_of_date'])
            : null,
        walkPerDay: json['walk_per_day'],
        mealPerDay: json['meal_per_day'],
        workerId: json['worker_id'],
        price: json['price'],
      );
    } catch (e) {
      print('Error parsing Order from JSON: $e');
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'status': status,
      'worker_name': workerName,
      'pet_name': petName,
      'pick_up_date': pickUpDate,
      'drop_of_date': dropOffDate,
      'walk_per_day': walkPerDay,
      'meal_per_day': mealPerDay,
      'worker_id': workerId,
      'price': price,
    };
  }
}
