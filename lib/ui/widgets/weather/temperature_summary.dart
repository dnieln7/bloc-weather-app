import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/style/text_styles.dart';
import 'package:weather_app/ui/widgets/text/text.dart';
import 'package:weather_icons/weather_icons.dart';

class TemperatureSummary extends StatelessWidget {
  final int max;
  final int current;
  final int min;

  const TemperatureSummary({
    required this.max,
    required this.current,
    required this.min,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: IconText(
                  text: 'Temperature',
                  icon: WeatherIcons.thermometer,
                  style: TextStyles.titleMedium(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconText(
                adaptiveIconSize: false,
                text: 'Max: $max°',
                icon: WeatherIcons.direction_up,
                style: TextStyles.titleMedium(context),
              ),
              Text('$current°', style: TextStyles.headlineLarge(context)),
              IconText(
                reversed: true,
                adaptiveIconSize: false,
                text: 'Min: $min°',
                icon: WeatherIcons.direction_down,
                style: TextStyles.titleMedium(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}