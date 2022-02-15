class LocationMarker {
  String city;
  double lon;
  double lat;
  String description;
  double temperature;

  LocationMarker.fromJson(Map json) :
        city = json['name'],
        lon = json['coord']['lon'],
        lat = json['coord']['lat'],
        description = json['weather'][0]['description'],
        temperature = json['main']['temp'];

  Map toJson() {
    return { 'city' : city, 'lon' : lon, 'lat' : lat, 'description' : description, 'temperature' : temperature };
  }
}