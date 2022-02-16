class Weather {
  String city;
  double lon;
  double lat;
  double temperature;
  String weatherIcon;

  Weather.fromJson(Map json)
      : city = json['name'],
        lon = json['coord']['lon'],
        lat = json['coord']['lat'],
        temperature = json['main']['temp'],
        weatherIcon = json['weather'][0]['icon'];

  Map toJson() {
    return { 'city' : city, 'lon' : lon, 'lat' : lat, 'temperature' : temperature, 'weatherIcon' : weatherIcon};
  }
}