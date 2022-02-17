import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

import 'package:weather_application/networking/apiBaseHelper.dart';
import 'package:weather_application/model/weather.dart';

class WeatherDAO {
  final String _apiKey = "8d82707fc5578d8279a22549a1ac45ee";

  final ApiBaseHelper _helper = ApiBaseHelper();

  //api call
  Future<List<Weather>> fetchWeatherList() async {
    final response = await _helper.get("q=London&appid=$_apiKey");

    List<Weather> weatherResponse = <Weather>[];
    weatherResponse.add(Weather.fromJson(response));
    return weatherResponse;
  }
  //for reading json file
  static Future<String> getWeather() {
    Future<String> result = rootBundle.loadString('res/weather.json');
    return result;
  }
}