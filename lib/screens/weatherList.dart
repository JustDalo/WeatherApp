import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_application/model/weather.dart';
import 'package:weather_application/dao/weatherDAO.dart';

class WeatherList extends StatefulWidget {
  const WeatherList({Key? key}) : super(key: key);

  @override
  _WeatherListState createState() => _WeatherListState();
}

class _WeatherListState extends State<WeatherList> {
  List<Weather> weatherList = <Weather>[];

  void getWeather() async {
    WeatherDAO.getWeather().then((response) {
      setState(() {
        Iterable list = json.decode(response);
        weatherList = list.map((model) => Weather.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: weatherList.length,
            itemBuilder: (context, index) {
              return Card(
                  child: Text(weatherList[index].city +
                      ',' +
                      weatherList[index].lat.toString()));
            }));
  }
}
//child: Text(weatherList[index].base + ',' + weatherList[index].country),
