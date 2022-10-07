import 'package:flutter/material.dart';
import 'package:weather_app/domain/enums/enums.dart';

class ColorStyles {
  static LinearGradient getTemperatureGradient(TemperatureType temperatureType) {
    final List<Color> colors = [];

    if (temperatureType == TemperatureType.veryHot) {
      colors.add(Colors.red.shade800);
      colors.add(Colors.red.shade500);
      colors.add(Colors.red.shade300);
    } else if (temperatureType == TemperatureType.hot) {
      colors.add(Colors.orange.shade800);
      colors.add(Colors.orange.shade500);
      colors.add(Colors.orange.shade300);
    } else if (temperatureType == TemperatureType.neutral) {
      colors.add(Colors.green.shade800);
      colors.add(Colors.green.shade500);
      colors.add(Colors.green.shade300);
    } else if (temperatureType == TemperatureType.cold) {
      colors.add(Colors.blue.shade800);
      colors.add(Colors.blue.shade500);
      colors.add(Colors.blue.shade300);
    } else {
      colors.add(Colors.indigo.shade800);
      colors.add(Colors.indigo.shade500);
      colors.add(Colors.indigo.shade300);
    }

    return LinearGradient(
      colors: colors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
}
