class Weather {
  String city;
  double lon;
  double lat;
  String description;

  Weather.fromJson(Map json)
      : city = json['name'],
        lon = json['coord']['lon'],
        lat = json['coord']['lat'],
        description = json['weather'][0]['description'];

  Map toJson() {
    return { 'city' : city, 'lon' : lon, 'lat' : lat, 'description' : description };
  }
}