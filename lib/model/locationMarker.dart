class LocationMarker {
  double lon;
  double lat;
  String description;

  LocationMarker.fromJson(Map json) :
        lon = json['coord']['lon'],
        lat = json['coord']['lat'],
        description = json['weather'][0]['description'];

  Map toJson() {
    return { 'lon' : lon, 'lat' : lat, 'description' : description };
  }
}