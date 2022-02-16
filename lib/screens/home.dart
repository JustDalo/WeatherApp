import 'package:flutter/material.dart';
import 'package:weather_application/screens/settings.dart';
import 'package:weather_application/screens/weatherList.dart';
import 'package:weather_application/screens/map.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('Weather Forecast'),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.ac_unit)),
                Tab(icon: Icon(Icons.location_pin)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              WeatherList(),
              Map(),
              Setting(),
            ],
          ),
        ),
      ),
    );
  }
}
