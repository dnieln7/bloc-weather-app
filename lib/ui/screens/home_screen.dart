import 'package:flutter/material.dart';
import 'package:weather_app/domain/enum/enums.dart';
import 'package:weather_app/ui/widgets/animated/animated.dart';
import 'package:weather_app/ui/widgets/style/text_styles.dart';
import 'package:weather_app/ui/widgets/weather/weather.dart';

const String homeScreenRoute = "/";

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final bool searching = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: searching
            ? BlinkingContainer(
                child: Text(
                  'Loading ...',
                  style: TextStyles.titleLarge(context),
                ),
              )
            : Container(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_rounded),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: getGradient(-20)),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.12,
          bottom: MediaQuery.of(context).size.height * 0.10,
          right: MediaQuery.of(context).size.width * 0.05,
          left: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          children: const [
            WeatherLocation(city: 'Orizaba'),
            Expanded(
              child: WeatherSummary(weatherType: WeatherType.snowFall),
            ),
            TemperatureSummary(max: 30, current: 20, min: 10),
          ],
        ),
      ),
    );
  }

  LinearGradient getGradient(double temperature) {
    final List<Color> colors = [];

    if (temperature > 35) {
      colors.add(Colors.red.shade800);
      colors.add(Colors.red.shade500);
      colors.add(Colors.red.shade300);
    } else if (temperature > 25) {
      colors.add(Colors.orange.shade800);
      colors.add(Colors.orange.shade500);
      colors.add(Colors.orange.shade300);
    } else if (temperature > 15) {
      colors.add(Colors.green.shade800);
      colors.add(Colors.green.shade500);
      colors.add(Colors.green.shade300);
    } else if (temperature > 0) {
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
