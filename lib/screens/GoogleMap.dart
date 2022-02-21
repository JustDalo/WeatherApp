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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GoogleMap(
          markers: Set.from(
            markers,
          ),
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.lat, widget.lon),
            zoom: 10,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        );
  }

  @override
  bool get wantKeepAlive => true;
}
