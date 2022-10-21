import 'package:flutter/material.dart';
import 'package:weather_app/domain/enum/enums.dart';

class AppColors {
  static LinearGradient getTemperatureGradient(
    TemperatureType temperatureType,
  ) {
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
    } else if (temperatureType == TemperatureType.veryCold) {
      colors.add(Colors.indigo.shade800);
      colors.add(Colors.indigo.shade500);
      colors.add(Colors.indigo.shade300);
    } else {
      colors.add(Colors.grey.shade800);
      colors.add(Colors.grey.shade500);
      colors.add(Colors.grey.shade300);
    }

    return LinearGradient(
      colors: colors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  static Color getTemperatureSolid(TemperatureType temperatureType) {
    if (temperatureType == TemperatureType.veryHot) {
      return Colors.red.shade500;
    } else if (temperatureType == TemperatureType.hot) {
      return Colors.orange.shade500;
    } else if (temperatureType == TemperatureType.neutral) {
      return Colors.green.shade500;
    } else if (temperatureType == TemperatureType.cold) {
      return Colors.blue.shade500;
    } else if (temperatureType == TemperatureType.veryCold) {
      return Colors.indigo.shade500;
    } else {
      return Colors.grey.shade500;
    }
  }
}
