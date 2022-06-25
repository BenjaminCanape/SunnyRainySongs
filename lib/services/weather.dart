import 'dart:convert';

import 'package:http/http.dart';

const Map weatherEnum = {
  'RAIN': "Sad",
  'SUN': "Summer",
  'CLOUD': "Fall",
  'SNOW': "Christmas",
  'NIGHT': "Sleep",
  'MIST': "Horror",
  'THUNDER': "Horror",
  'BLIZZARD': "Winter",
  'ICE_PELLETS': "Horror"
};

class Weather {
  static const String weatherApiKey = 'Key';
  static const String baseUrl = "https://api.weatherapi.com/v1";

  String iconWeather = "";
  String weather = "";
  bool isDay = true;
  String searchText = "";

  Future<void> getWeatherResponseFromAPI(
      double latitude, double longitude) async {
    String url =
        "$baseUrl/current.json?key=$weatherApiKey&q=$latitude,$longitude";

    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    if (data.isNotEmpty) {
      iconWeather = data['current']?['condition']?['icon'];
      weather = data['current']?['condition']?['text'];
      getSearchTextFromWeather();
      isDay = data['current']?['is_day'] != 0;
    }
  }

  getSearchTextFromWeather() {
    if (weather.isNotEmpty) {
      switch (weather) {
        case "Sunny":
          searchText = weatherEnum['SUN'];
          break;
        case "Clear":
          searchText = weatherEnum['NIGHT'];
          break;
        case "Partly Cloudy":
        case "Cloudy":
        case "Overcast":
          searchText = weatherEnum['CLOUD'];
          break;
        case "Patchy rain nearby":
        case "Patchy light rain":
        case "Light rain":
        case "Moderate rain at times":
        case "Moderate rain":
        case "Heavy rain at times":
        case "Heavy rain":
        case "Light freezing rain":
        case "Moderate or heavy freezing rain":
        case "Light rain shower":
        case "Moderate or heavy rain shower":
        case "Torrential rain shower":
          searchText = weatherEnum['RAIN'];
          break;
        case "Patchy snow nearby":
        case "Blowing snow":
        case "Patchy light snow":
        case "Light snow":
        case "Patchy moderate snow":
        case "Moderate snow":
        case "Patchy heavy snow":
        case "Heavy snow":
        case "Light snow showers":
        case "Moderate or heavy snow showers":
          searchText = weatherEnum['SNOW'];
          break;
        case "Mist":
        case "Patchy freezing drizzle nearby":
        case "Patchy light drizzle":
        case "Patchy sleet nearby":
        case "Fog":
        case "Light drizzle":
        case "Freezing drizzle":
        case "Heavy freezing drizzle":
        case "Light sleet":
        case "Moderate or heavy sleet":
        case "Light sleet showers":
        case "Moderate or heavy sleet showers":
          searchText = weatherEnum['MIST'];
          break;
        case "Blizzard":
          searchText = weatherEnum['BLIZZARD'];
          break;
        case "Ice pellets":
        case "Light showers of ice pellets":
          searchText = weatherEnum['ICE_PELLETS'];
          break;
        case "Thundery outbreaks in nearby":
        case "Patchy light rain in area with thunder":
        case "Moderate or heavy rain in area with thunder":
        case "Patchy light snow in area with thunder":
        case "Moderate or heavy snow in area with thunder":
          searchText = weatherEnum['THUNDER'];
          break;
        default:
          searchText = weatherEnum['RAIN'];
      }
    }
  }
}
