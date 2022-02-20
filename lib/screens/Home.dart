import 'package:flutter/material.dart';
import 'package:weather_application/screens/Settings.dart';
import 'package:weather_application/screens/GoogleMap.dart';
import 'package:weather_application/screens/weather_list/WeatherPageRoutes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final Widget _appBarTitle = const Text("Weather Forecast");

  static const List<Widget> _widgetOptions = <Widget>[
    WeatherPageRoutes(),
    Map(lat: 53.9024716, lon: 27.5618225),
    Setting(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.black,
              title: _appBarTitle),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
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
            selectedItemColor: Colors.amber[800],
          ),
        ),
      ),
    );
  }
}
