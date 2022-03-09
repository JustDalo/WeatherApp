import 'package:logger/logger.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:weather_application/model/Weather.dart';

class WeatherDAO {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

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
      logger.e(e.toString());
    }
  }

  Future<DataSnapshot> getData() async {
    return databaseReference.get();
  }

  void updateData(String city, Weather weatherData) {
    try {
      databaseReference.child(city).update({
        'temperature': weatherData.temperature,
        'description': weatherData.description,
        'icon': weatherData.weatherIcon,
      });
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void deleteData(String city) {
    try {
      databaseReference.child(city).remove();
    } catch (e) {
      logger.e(e.toString());
    }
  }
}
