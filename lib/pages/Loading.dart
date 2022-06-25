import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import 'package:sunny_rainy_songs/services/location.dart';
import 'package:sunny_rainy_songs/services/music.dart';
import 'package:sunny_rainy_songs/services/weather.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  getWeather() async {
    Music musicService = Music();
    LocationService locationService = LocationService();
    await locationService.getUserLocation();
    print(locationService.locationData);
    Weather weatherService = Weather();
    LocationData? locationData = locationService.locationData;
    if (locationData == null ||
        locationData.latitude == null ||
        locationData.latitude == null) {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'weather': weatherService.weather,
        'iconWeather': weatherService.iconWeather,
        'playlistsFrames': []
      });

      return;
    }
    await weatherService.getWeatherResponseFromAPI(
        locationService.locationData?.latitude ?? 0.0,
        locationService.locationData?.longitude ?? 0.0);

    await musicService.searchPlaylist(weatherService.weather);
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'weather': weatherService.weather,
      'iconWeather': weatherService.iconWeather,
      'isDay': weatherService.isDay,
      'playlistsFrames': musicService.playlistFrames
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          ),
        ));
  }
}
