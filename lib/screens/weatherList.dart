import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:weather_application/controls/fontColorController.dart';
import 'package:weather_application/controls/fontSizeController.dart';
import 'package:weather_application/controls/weatherController.dart';

import 'package:weather_application/model/weather.dart';
import 'package:weather_application/dao/weatherDAO.dart';
import 'package:weather_application/networking/apiResponse.dart';

import 'package:weather_application/screens/map.dart';

class WeatherList extends StatefulWidget {
  const WeatherList({Key? key}) : super(key: key);

  @override
  _WeatherListState createState() => _WeatherListState();
}

class _WeatherListState extends State<WeatherList>
    with AutomaticKeepAliveClientMixin {
  List<Weather> weatherList = <Weather>[];
  late WeatherController _controller;

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
                      return Loading(loadingMessage: snapshot.data?.message);

                    case Status.COMPLETED:
                      return WeatherListView(weatherList: snapshot.data?.data);

                    case Status.ERROR:
                      return Error(
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

class WeatherListView extends StatelessWidget {
  final List<Weather>? weatherList;

  const WeatherListView({Key? key, required this.weatherList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: weatherList!.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(weatherList![index].city,
                  style: TextStyle(
                      fontSize:
                          Provider.of<FontSizeController>(context, listen: true)
                              .value,
                      color:
                          Provider.of<FontColorController>(context, listen: true)
                              .value)),
              subtitle: Text(
                  weatherList![index].lat.toString() +
                      ', ' +
                      weatherList![index].lon.toString(),
                  style: TextStyle(
                      color:
                          Provider.of<FontColorController>(context, listen: true)
                              .value)),
              leading: Image.network(
                  'https://openweathermap.org/img/wn/${weatherList![index].weatherIcon}@2x.png'),
              trailing: Text(
                weatherList![index].temperature.toString(),
                style: TextStyle(
                    color:
                        Provider.of<FontColorController>(context, listen: true)
                            .value),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Map(
                            lat: weatherList![index].lat,
                            lon: weatherList![index].lon)));
              });
        });
  }
}

class Error extends StatelessWidget {
  final String? errorMessage;
  final Function onRetryPressed;

  const Error(
      {Key? key, required this.errorMessage, required this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            child: const Text(
              'Retry',
            ),
            onPressed: onRetryPressed(),
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String? loadingMessage;

  const Loading({Key? key, required this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 24),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}
