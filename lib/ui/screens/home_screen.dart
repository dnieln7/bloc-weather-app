import 'package:flutter/material.dart';
import 'package:weather_app/domain/enum/enums.dart';
import 'package:weather_app/ui/widgets/animated/animated.dart';
import 'package:weather_app/ui/widgets/style/text_styles.dart';
import 'package:weather_app/ui/widgets/weather/weather.dart';

const String homeScreenRoute = "/";

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final Color weatherColorStart = Colors.blue.shade800;
  final Color weatherColorCenter = Colors.blue.shade500;
  final Color weatherColorEnd = Colors.blue.shade300;

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
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [weatherColorStart, weatherColorCenter, weatherColorEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.12,
          bottom: MediaQuery.of(context).size.height * 0.10,
          right: MediaQuery.of(context).size.width * 0.05,
          left: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          children: const [
            WeatherLocation(city: 'a'),
            Expanded(
              child: WeatherSummary(weatherType: WeatherType.rainShower),
            ),
            TemperatureSummary(max: 30, current: 20, min: 10),
          ],
        ),
      ),
    );
  }
}
