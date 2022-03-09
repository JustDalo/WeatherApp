class City {
  String name;

  City.fromJson(Map<String, dynamic> json)
    : name = json['name'];

  Map toJson() {
    return {
      'name': name,
    };
  }
}