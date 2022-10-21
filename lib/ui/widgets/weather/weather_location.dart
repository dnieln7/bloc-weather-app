import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:weather_app/ui/widgets/style/app_texts.dart';

class WeatherLocation extends StatelessWidget {
  final String city;

  const WeatherLocation({
    required this.city,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          city,
          textAlign: TextAlign.center,
          style: AppTexts.displayMedium(context),
        ),
        const SizedBox(height: 15),
        Text(
          _getDate(Localizations.localeOf(context).languageCode),
          textAlign: TextAlign.center,
          style: AppTexts.headlineSmall(context),
        )
      ],
    );
  }

  String _getDate(String locale) {
    final now = DateTime.now();

    return DateFormat.MMMMEEEEd(locale).format(now).sentenceCase;
  }
}
