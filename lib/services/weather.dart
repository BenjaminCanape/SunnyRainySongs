import 'dart:convert';

import 'package:http/http.dart';

class Weather {
  static const String weatherApiKey = 'Key';
  static const String baseUrl = "https://api.weatherapi.com/v1";

  String iconWeather = "";
  String weather = "";

  Future<void> getWeatherResponseFromAPI(
      double latitude, double longitude) async {
    String url =
        "$baseUrl/current.json?key=$weatherApiKey&q=$latitude,$longitude";

    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    if (data.isNotEmpty) {
      iconWeather = data['current']?['condition']?['icon'];
      weather = data['current']?['condition']?['text'];
    }
  }
}
