import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/style/text_styles.dart';
import 'package:weather_app/ui/widgets/text/text.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TemperatureSummary extends StatelessWidget {
  final AppLocalizations localizations;
  final int max;
  final int current;
  final int min;
  final bool useMetricSystem;

  const TemperatureSummary({
    required this.localizations,
    required this.max,
    required this.current,
    required this.min,
    required this.useMetricSystem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconText(
          adaptiveIconSize: false,
          text: "${localizations.temperature} (${useMetricSystem ? '°C' : '°F'})",
          icon: Icons.thermostat_rounded,
          style: TextStyles.titleMedium(context),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconText(
              adaptiveIconSize: false,
              text: '${localizations.max}: $max°',
              icon: WeatherIcons.direction_up,
              style: TextStyles.titleMedium(context),
            ),
            Text(
              '$current°',
              style: TextStyles.headlineLarge(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconText(
              reversed: true,
              adaptiveIconSize: false,
              text: '${localizations.min}: $min°',
              icon: WeatherIcons.direction_down,
              style: TextStyles.titleMedium(context),
            ),
          ],
        ),
      ],
    );
  }
}
