import 'dart:convert';
import 'package:provider/provider.dart';

import 'package:weather_application/controls/fontSizeController.dart';

import 'package:flutter/material.dart';
import 'package:weather_application/model/weather.dart';
import 'package:weather_application/dao/weatherDAO.dart';

class WeatherList extends StatefulWidget {
  const WeatherList({Key? key}) : super(key: key);

  @override
  _WeatherListState createState() => _WeatherListState();
}

class _WeatherListState extends State<WeatherList> with AutomaticKeepAliveClientMixin {
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
              return ListTile(
                title: Text(weatherList[index].city,
                    style: TextStyle(
                        fontSize: Provider.of<FontSizeController>(context,
                                listen: true)
                            .value)),
                subtitle: Text(weatherList[index].lat.toString() +
                    ', ' +
                    weatherList[index].lon.toString()),
              );
            }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
//child: Text(weatherList[index].base + ',' + weatherList[index].country),
