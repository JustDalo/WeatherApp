import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:weather_application/dao/DAO.dart';
import 'package:weather_application/model/City.dart';
import 'package:weather_application/networking/ApiBaseHelper.dart';
import 'package:weather_application/model/Weather.dart';

class WeatherRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final WeatherDAO _weatherDAO = WeatherDAO();

  //api call
  Future<List<Weather>> fetchWeatherList() async {
    List<Weather> weatherResponse = <Weather>[];
    List<City> cityObj = <City>[];

    await _weatherDAO.getData().then((DataSnapshot snapshot) {
      var cityObjsJson = (snapshot.value) as List;

      for (int i = 0; i < cityObjsJson.length; i++) {
        if (cityObjsJson[i] != null) {
          final myMap = Map<String, dynamic>.from(cityObjsJson[i]);
          cityObj.add(City.fromJson(myMap));
        }
      }
    });
    if (cityObj.isNotEmpty) {
      for (int i = 0; i < cityObj.length; i++) {
        var response = await _helper.get(cityObj[i].name);
        weatherResponse.add(Weather.fromJson(response));
      }
    }

    /*response = await _helper.get("Minsk");
    weatherResponse.add(Weather.fromJson(response));

    response = await _helper.get("Llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch");
    weatherResponse.add(Weather.fromJson(response));

    response = await _helper.get("Tokyo");
    weatherResponse.add(Weather.fromJson(response));

    response = await _helper.get("Paris");
    weatherResponse.add(Weather.fromJson(response));

    response = await _helper.get("Vancouver");
    weatherResponse.add(Weather.fromJson(response));*/

    return weatherResponse;
  }

  //for reading json file
  static Future<String> getWeather() {
    Future<String> result = rootBundle.loadString('res/weather.json');
    return result;
  }
}
