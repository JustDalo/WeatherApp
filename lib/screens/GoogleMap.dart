import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_application/model/Weather.dart';

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

  Icon _searchIcon = const Icon(Icons.search);
  BorderRadius _buttonRadius = const BorderRadius.all(Radius.circular(16.0));

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

  Widget _showSearchBar() {
    if (_searchIcon.icon == Icons.cancel) {
      return Column(children: <Widget>[
        Padding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 72),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: const InputDecoration(
                  fillColor: Colors.white,
                  labelText: "Search",
                  hintText: "City?..",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.zero,
                          bottomRight: Radius.zero,
                          topLeft: Radius.circular(25.0),
                          bottomLeft: Radius.circular(25.0)))),
            )),
        Expanded(
            child: ListView.builder(
                itemCount: citiesList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 1, bottom: 11, left: 16, right: 16),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          title: Text(
                            citiesList[index].city,
                          ),
                          tileColor: Colors.red,
                          onTap: () => _goToTheCity(
                              citiesList[index].lat, citiesList[index].lon),
                        ))
                  );


                })),
      ]);
    } else {
      return const Text("");
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
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: 56,
                      height: 60,
                      child: FittedBox(
                          child: FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  if (_searchIcon.icon == Icons.search) {
                                    _searchIcon = const Icon(Icons.cancel);
                                    _buttonRadius = const BorderRadius.only(
                                        topLeft: Radius.zero,
                                        bottomLeft: Radius.zero,
                                        topRight: Radius.circular(16),
                                        bottomRight: Radius.circular(16));
                                  } else {
                                    _searchIcon = const Icon(Icons.search);
                                    _buttonRadius = const BorderRadius.all(
                                        Radius.circular(16.0));
                                  }
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              backgroundColor: Colors.amber,
                              child: _searchIcon,
                              shape: RoundedRectangleBorder(
                                borderRadius: _buttonRadius,
                              ))))
                ],
              ),
            )),
        _showSearchBar(),
      ]),
    );
  }

  Future<void> _goToTheCity(double lat, double lon) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lon),
      zoom: 10,
    )));
  }

  @override
  bool get wantKeepAlive => true;
}
