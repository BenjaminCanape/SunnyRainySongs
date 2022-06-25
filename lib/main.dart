import 'package:flutter/material.dart';
import 'package:sunny_rainy_songs/pages/Loading.dart';
import 'package:sunny_rainy_songs/pages/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Loading(),
      '/home': (context) => const Home()
    },
  ));
}
