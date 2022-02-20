import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:weather_application/controls/WeatherController.dart';

import 'package:weather_application/model/Weather.dart';
import 'package:weather_application/networking/ApiResponse.dart';
import 'package:weather_application/repository/WeatherRepository.dart';
import 'package:weather_application/screens/weather_list/LoadingPage.dart';
import 'package:weather_application/screens/weather_list/ErrorPage.dart';
import 'package:weather_application/screens/weather_list/WeatherList.dart';

class WeatherPageRoutes extends StatefulWidget {
  const WeatherPageRoutes({Key? key}) : super(key: key);

  @override
  _WeatherListState createState() => _WeatherListState();
}

class _WeatherListState extends State<WeatherPageRoutes>
    with AutomaticKeepAliveClientMixin {
  List<Weather> weatherList = <Weather>[];
  late WeatherController _controller;

  void getWeather() async {
    WeatherRepository.getWeather().then((response) {
      setState(() {
        Iterable list = json.decode(response);
        weatherList = list.map((model) => Weather.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = WeatherController();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
            onRefresh: () => _controller.fetchWeatherList(),
            child: StreamBuilder<ApiResponse<List<Weather>>>(
              stream: _controller.weatherListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data?.status) {
                    case Status.LOADING:
                      return LoadingPage(loadingMessage: snapshot.data?.message);

                    case Status.COMPLETED:
                      return WeatherList(weatherList: snapshot.data?.data);

                    case Status.ERROR:
                      return ErrorPage(
                        errorMessage: snapshot.data?.message,
                        onRetryPressed: () => _controller.fetchWeatherList(),
                      );
                  }
                }
                return Container();
              },
            )));
  }

  @override
  bool get wantKeepAlive => true;
}

//weatherList: snapshot.data?.data