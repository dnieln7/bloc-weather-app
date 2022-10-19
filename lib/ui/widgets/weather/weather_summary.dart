import 'package:flutter/material.dart';
import 'package:weather_app/domain/enums/enums.dart';
import 'package:weather_app/ui/widgets/style/text_styles.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherSummary extends StatelessWidget {
  final WeatherType weatherType;
  final Orientation orientation;

  const WeatherSummary({
    required this.weatherType,
    required this.orientation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (orientation == Orientation.portrait) {
      return Column(
        children: [
          BoxedIcon(
            weatherIcon,
            color: Colors.white,
            size: MediaQuery.of(context).size.width / 3,
          ),
          const SizedBox(height: 10),
          Text(
            weather,
            textAlign: TextAlign.center,
            style: TextStyles.headlineLarge(context),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          BoxedIcon(
            weatherIcon,
            color: Colors.white,
            size: MediaQuery.of(context).size.height / 4,
          ),
          const SizedBox(height: 10),
          Text(
            weather,
            textAlign: TextAlign.center,
            style: TextStyles.headlineLarge(context),
          ),
        ],
      );
    }
  }

  IconData get weatherIcon {
    switch (weatherType) {
      case WeatherType.clearSky:
        return WeatherIcons.day_sunny;
      case WeatherType.cloudy:
        return WeatherIcons.cloudy;
      case WeatherType.fog:
        return WeatherIcons.fog;
      case WeatherType.drizzle:
        return WeatherIcons.sprinkle;
      case WeatherType.freezingDrizzle:
        return WeatherIcons.sprinkle;
      case WeatherType.rain:
        return WeatherIcons.rain;
      case WeatherType.rainShower:
        return WeatherIcons.showers;
      case WeatherType.thunderstorm:
        return WeatherIcons.thunderstorm;
      case WeatherType.hailThunderstorm:
        return WeatherIcons.storm_showers;
      case WeatherType.freezingRain:
        return WeatherIcons.rain_wind;
      case WeatherType.snowFall:
        return WeatherIcons.snow;
      case WeatherType.snowGrains:
        return WeatherIcons.snowflake_cold;
      case WeatherType.snowShower:
        return WeatherIcons.snow_wind;
      case WeatherType.unknown:
        return WeatherIcons.na;
    }
  }

  String get weather {
    switch (weatherType) {
      case WeatherType.clearSky:
        return 'Clear sky';
      case WeatherType.cloudy:
        return 'Partly cloudy';
      case WeatherType.fog:
        return 'Fog';
      case WeatherType.drizzle:
        return 'Drizzle';
      case WeatherType.freezingDrizzle:
        return 'Freezing drizzle';
      case WeatherType.rain:
        return 'Rain';
      case WeatherType.rainShower:
        return 'Rain showers';
      case WeatherType.thunderstorm:
        return 'Thunderstorm';
      case WeatherType.hailThunderstorm:
        return 'Thunderstorm with hail';
      case WeatherType.freezingRain:
        return 'Freezing rain';
      case WeatherType.snowFall:
        return 'Snow fall';
      case WeatherType.snowGrains:
        return 'Snow grains';
      case WeatherType.snowShower:
        return 'Snow showers';
      case WeatherType.unknown:
        return 'Unknown';
    }
  }
}
