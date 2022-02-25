import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:weather_application/dao/DAO.dart';

import 'package:weather_application/networking/ApiBaseHelper.dart';
import 'package:weather_application/model/Weather.dart';

class WeatherRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  //api call
  Future<List<Weather>> fetchWeatherList() async {
    List<Weather> weatherResponse = <Weather>[];

    var response = await _helper.get("London");
    weatherResponse.add(Weather.fromJson(response));

    response = await _helper.get("Minsk");
    weatherResponse.add(Weather.fromJson(response));

    return weatherResponse;
  }

  //for reading json file
  static Future<String> getWeather() {
    Future<String> result = rootBundle.loadString('res/weather.json');
    return result;
  }
}