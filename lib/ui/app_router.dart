import 'package:flutter/material.dart';
import 'package:weather_app/ui/screens/screens.dart';

class AppRouter {
  Route<Object?>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreenRoute:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      default:
        return null;
    }
  }
}
