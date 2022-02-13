import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_application/model/locationMarker.dart';

import '../dao/WeatherDAO.dart';

class Map extends StatefulWidget {
  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  List<LocationMarker> location = <LocationMarker>[];
  Set<Marker> markerSet = <Marker>{};

  Iterable markers = [];

  MarkerId? selectedMarker;
  int _markerIdCounter = 1;
  LatLng? markerPosition;

  void getWeather() async {
    await WeatherDAO.getWeather().then((response) {
      setState(() {
        Iterable list = json.decode(response);
        location = list.map((model) => LocationMarker.fromJson(model)).toList();
      });
    });

    Iterable _markers = Iterable.generate(location.length, (index) {

      LatLng latLngMarker = LatLng(location[index].lat, location[index].lon);

      return Marker(markerId: MarkerId("marker$index"), infoWindow: InfoWindow(title: location[index].description),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), position: latLngMarker);
    });
    setState(() {
      markers = _markers;
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(53.9024716, 27.5618225),
    zoom: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set.from(
          markers,
        ),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Marker _addMarker(LocationMarker location) {

    return Marker(
      markerId: MarkerId(location.description),
      infoWindow: InfoWindow(title: location.description),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: LatLng(location.lat, location.lon),
    );
  }
}

