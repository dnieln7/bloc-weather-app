import 'package:flutter/material.dart';
import 'package:weather_app/domain/enums/enums.dart';
import 'package:weather_app/ui/widgets/style/text_styles.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherSummary extends StatelessWidget {
  final AppLocalizations localizations;
  final WeatherType weatherType;
  final Orientation orientation;

  const WeatherSummary({
    required this.localizations,
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
        return localizations.clearSky;
      case WeatherType.cloudy:
        return localizations.cloudy;
      case WeatherType.fog:
        return localizations.fog;
      case WeatherType.drizzle:
        return localizations.drizzle;
      case WeatherType.freezingDrizzle:
        return localizations.freezingDrizzle;
      case WeatherType.rain:
        return localizations.rain;
      case WeatherType.rainShower:
        return localizations.rainShower;
      case WeatherType.thunderstorm:
        return localizations.thunderstorm;
      case WeatherType.hailThunderstorm:
        return localizations.hailThunderstorm;
      case WeatherType.freezingRain:
        return localizations.freezingRain;
      case WeatherType.snowFall:
        return localizations.snowFall;
      case WeatherType.snowGrains:
        return localizations.snowGrains;
      case WeatherType.snowShower:
        return localizations.snowShower;
      case WeatherType.unknown:
        return localizations.unknown;
    }
  }
}
