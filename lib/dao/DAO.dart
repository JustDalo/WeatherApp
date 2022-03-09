import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:weather_application/model/Weather.dart';


class WeatherDAO {
  final databaseReference = FirebaseDatabase.instance.ref().child("cities");

  void createRecord(String? city, Weather? weatherData) {
    try {
      databaseReference.child(city!).set({
        'lat': weatherData!.lat,
        'lon': weatherData.lon,
        'temperature': weatherData.temperature,
        'description': weatherData.description,
        'icon': weatherData.weatherIcon,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<DataSnapshot> getData() async {
    return databaseReference.get();
  }

  void updateData(String city, Weather weatherData) {
    databaseReference.child(city).update({
      'temperature': weatherData.temperature,
      'description': weatherData.description,
      'icon': weatherData.weatherIcon,
    });
  }

  void deleteData(String city) {
    databaseReference.child(city).remove();
  }
}
