import 'package:flutter/material.dart';
import 'package:weather_application/screens/Settings.dart';
import 'package:weather_application/screens/GoogleMap.dart';
import 'package:weather_application/screens/WeatherList.dart';
import 'package:weather_application/screens/LoadingPage.dart';
import 'package:weather_application/screens/ErrorPage.dart';

import 'package:weather_application/controls/WeatherController.dart';

import 'package:weather_application/model/Weather.dart';
import 'package:weather_application/networking/ApiResponse.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<TabBarPage>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  final Widget _appBarTitle = const Text("Weather Forecast");
  late WeatherController _controller;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = WeatherController();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.black, title: _appBarTitle),
          body: RefreshIndicator(
              onRefresh: () => _controller.fetchWeatherList(),
              child: StreamBuilder<ApiResponse<List<Weather>>>(
                stream: _controller.weatherListStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data?.status) {
                      case Status.LOADING:
                        return LoadingPage(
                            loadingMessage: snapshot.data?.message);

                      case Status.COMPLETED:
                        if (_selectedIndex == 0) {
                          return WeatherList(weatherList: snapshot.data?.data);
                        } else if (_selectedIndex == 1) {
                          return GoogleMapPage(
                              lat: 53.902471,
                              lon: 27.561824,
                              weatherList: snapshot.data?.data);
                        } else {
                          return const Setting();
                        }

                      case Status.ERROR:
                        return ErrorPage(
                          errorMessage: snapshot.data?.message,
                          onRetryPressed: () => _controller.fetchWeatherList(),
                        );
                    }
                  }
                  return Container();
                },
              )),
          /*Center(
            child: _widgetOptions.elementAt(_selectedIndex),*/

          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.ac_unit), label: 'weather'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_pin), label: 'map'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'settings'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.amber,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
