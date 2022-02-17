class Weather {
  String city;
  double lon;
  double lat;
  double temperature;
  String description;
  String weatherIcon;

  Weather.fromJson(Map<String, dynamic> json)
      : city = json['name'],
        lon = json['coord']['lon'],
        lat = json['coord']['lat'],
        temperature = json['main']['temp'],
        description = json['weather'][0]['description'],
        weatherIcon = json['weather'][0]['icon'];

  Map toJson() {
    return {
      'city': city,
      'lon': lon,
      'lat': lat,
      'temperature': temperature,
      'description': description,
      'weatherIcon': weatherIcon
    };
  }
}
