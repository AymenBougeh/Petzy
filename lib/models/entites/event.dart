class Event {
  String title;
  String description;
  String date;

  Event({this.title, this.description, this.date});

  Event.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;

    return data;
  }
}
