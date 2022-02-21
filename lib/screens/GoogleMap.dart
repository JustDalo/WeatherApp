import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_application/model/Weather.dart';
import 'package:weather_application/repository/WeatherRepository.dart';

class GoogleMapPage extends StatefulWidget {
  final double lat;
  final double lon;
  final List<Weather>? weatherList;

  const GoogleMapPage(
      {Key? key,
      required this.lat,
      required this.lon,
      required this.weatherList})
      : super(key: key);

  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMapPage>
    with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController editingController = TextEditingController();
  List<Weather> citiesList = <Weather>[];

  Iterable markers = [];

  void _setMarkers() {
    Iterable _markers = Iterable.generate(widget.weatherList!.length, (index) {
      LatLng latLngMarker = LatLng(
          widget.weatherList![index].lat, widget.weatherList![index].lon);

      return Marker(
          markerId: MarkerId("marker_$index"),
          infoWindow: InfoWindow(
              title: widget.weatherList![index].city +
                  ' (' +
                  widget.weatherList![index].lat.toString() +
                  ', ' +
                  widget.weatherList![index].lon.toString() +
                  ') ',
              snippet: widget.weatherList![index].temperature.toString() +
                  "F, " +
                  widget.weatherList![index].description),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: latLngMarker);
    });
    setState(() {
      markers = _markers;
    });
  }

  @override
  void initState() {
    super.initState();
    _setMarkers();
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
        citiesList.clear();
        citiesList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        citiesList.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
        body: Stack(children: <Widget>[
      GoogleMap(
        markers: Set.from(
          markers,
        ),
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.lon),
          zoom: 9,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              filterSearchResults(value);
            },
            controller: editingController,
            decoration: const InputDecoration(
                labelText: "Search",
                hintText: "City?..",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
                child: ListView.builder(
                    itemCount: citiesList.length,
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              citiesList[index].city,
                            ),
                            tileColor: Colors.red,
                            onTap: () => _goToTheLake(
                                citiesList[index].lat, citiesList[index].lon),
                          ));
                    }))),
      ]),
    ]));
  }

  Future<void> _goToTheLake(double lat, double lon) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lon),
      zoom: 10,
    )));
  }

  @override
  bool get wantKeepAlive => true;
}
