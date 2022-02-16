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
  int _selectedIndex = 0;
  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle = const Text("Weather Forecast");

  static const List<Widget> _widgetOptions = <Widget>[
    WeatherList(),
    Map(lat: 53.9024716, lon: 27.5618225),
    Setting(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchTapped() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.cancel);
        _appBarTitle = const ListTile(
            leading: Icon(
              Icons.search,
              color: Colors.white,
              size: 28,
            ),
            title: TextField(
                decoration: InputDecoration(
                  hintText: 'type in city name...',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: Colors.white,
                )));
      } else {
        _searchIcon = const Icon(Icons.search);
        _appBarTitle = const Text('Weather Forecast');
      }
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
              title: _appBarTitle,
              actions: [
                IconButton(
                  icon: _searchIcon,
                  onPressed: _onSearchTapped,
                ),
              ]),
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
