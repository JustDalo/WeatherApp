import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_application/networking/ApiExceptions.dart';
import 'dart:async';

class ApiBaseHelper {
  final String _apiKey = "8d82707fc5578d8279a22549a1ac45ee";

  Future<dynamic> get(String city) async {

    var responseJson;
    var apiUrl = Uri.https('api.openweathermap.org', '/data/2.5/weather', {'q': city, 'appid' : _apiKey});


    try {
      final response = await http.get(apiUrl);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
