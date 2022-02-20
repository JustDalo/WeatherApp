import 'package:firebase_database/firebase_database.dart';
import 'package:weather_application/model/Weather.dart';
import 'package:firebase_core/firebase_core.dart';

class WeatherDAO {
  final databaseReference = FirebaseDatabase.instance.ref();

  //  WeatherDAO weatherDAO = WeatherDAO();
  // weatherDAO.createRecord("Moscow", snapshot.data?.data[0]);

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
      print(e);
    }
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
