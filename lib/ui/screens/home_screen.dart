import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/animated/animated_widgets.dart';
import 'package:weather_app/ui/widgets/style/style.dart';

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
          children: [
            Text('Orizaba', style: TextStyles.displayMedium(context)),
            const SizedBox(height: 5),
            Text(
              'Tuesday, 27 September 2022',
              textAlign: TextAlign.center,
              style: TextStyles.headlineSmall(context),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_rounded,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width / 2,
                  ),
                  Text('Cloudy', style: TextStyles.headlineLarge(context)),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.thermostat, color: Colors.white),
                      Expanded(
                        child: Text(
                          'Temperature',
                          style: TextStyles.titleMedium(context),
                        ),
                      ),
                      Text('More', style: TextStyles.titleSmall(context)),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Min: 18°', style: TextStyles.titleLarge(context)),
                      Text('20°', style: TextStyles.headlineLarge(context)),
                      Text('Max: 25°', style: TextStyles.titleLarge(context)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
