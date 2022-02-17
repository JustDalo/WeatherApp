import 'dart:async';

import 'package:weather_application/dao/weatherDAO.dart';
import 'package:weather_application/networking/apiResponse.dart';
import 'package:weather_application/model/weather.dart';

class WeatherController {
  late WeatherDAO _weatherRepository;
  late StreamController<ApiResponse<List<Weather>>> _weatherListController;

  StreamSink<ApiResponse<List<Weather>>> get weatherListSink =>
      _weatherListController.sink;

  Stream<ApiResponse<List<Weather>>> get weatherListStream =>
      _weatherListController.stream;

  WeatherController() {
    _weatherListController = StreamController<ApiResponse<List<Weather>>>();
    _weatherRepository = WeatherDAO();
    fetchWeatherList();
  }

  fetchWeatherList() async {
    weatherListSink.add(ApiResponse.loading('Fetching weather'));
    try {
      List<Weather> weathers = await _weatherRepository.fetchWeatherList();
      weatherListSink.add(ApiResponse.completed(weathers));
    } catch (e) {
      weatherListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _weatherListController.close();
  }
}
