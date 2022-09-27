import 'package:flutter/material.dart';
import 'package:weather_app/ui/app_router.dart';
import 'package:weather_app/ui/screens/screens.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  final AppRouter _router = AppRouter();

  WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: homeScreenRoute,
      onGenerateRoute: _router.onGenerateRoute,
    );
  }
}
