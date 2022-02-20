import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:weather_application/controls/FontColorController.dart';
import 'package:weather_application/controls/FontSizeController.dart';

import 'package:weather_application/model/Weather.dart';

import 'package:weather_application/screens/GoogleMap.dart';

class WeatherList extends StatefulWidget {
  final List<Weather>? weatherList;

  const WeatherList({Key? key, required this.weatherList}) : super(key: key);

  @override
  _WeatherListView createState() => _WeatherListView();
}

class _WeatherListView extends State<WeatherList> {
  final TextEditingController editingController = TextEditingController();
  final List<Weather> items = <Weather>[];

  @override
  void initState() {
    items.addAll(widget.weatherList!);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<Weather> dummySearchList = <Weather>[];
    dummySearchList.addAll(widget.weatherList!);
    if (query.isNotEmpty) {
      List<Weather> dummyListData = <Weather>[];
      for (var item in dummySearchList) {
        if (item.city.contains(query)) {
          dummyListData.add(item);
        }
      }

      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(widget.weatherList!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) {
            filterSearchResults(value);
          },
          controller: editingController,
          decoration: const InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)))),
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  items.removeAt(index);
                },
                child: ListTile(
                    title: Text(items[index].city,
                        style: TextStyle(
                            fontSize:
                                Provider.of<FontSizeController>(context, listen: true)
                                    .value,
                            color: Provider.of<FontColorController>(context, listen: true)
                                .value)),
                    subtitle: Text(
                        items[index].lat.toString() +
                            ', ' +
                            items[index].lon.toString(),
                        style: TextStyle(
                            color: Provider.of<FontColorController>(context, listen: true)
                                .value)),
                    leading: Image.network(
                        'https://openweathermap.org/img/wn/${items[index].weatherIcon}@2x.png'),
                    trailing: const Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Map(
                                  lat: items[index].lat,
                                  lon: items[index].lon)));
                    }),
                background: Container(
                  color: Colors.red,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ));
          },
        ),
      ),
    ]);
  }
}
