import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

class WeatherDAO {
  static Future<String> getWeather() {
    Future<String> result = rootBundle.loadString('res/weather.json');
    return result;
  }
}