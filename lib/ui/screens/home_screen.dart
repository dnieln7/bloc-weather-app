import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/animated/animated_widgets.dart';

const String homeScreenRoute = "/";

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final Color weatherColorStart = Colors.amber.shade800;
  final Color weatherColorCenter = Colors.amber.shade500;
  final Color weatherColorEnd = Colors.amber.shade300;

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
            ? const BlinkingContainer(
                child: Text(
                  'Loading ...',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
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
            Text(
              'Orizaba',
              style: TextStyle(
                color: Colors.white,
                fontSize:
                    Theme.of(context).textTheme.displayMedium?.fontSize ?? 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Tuesday, 27 September 2022',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize:
                    Theme.of(context).textTheme.headlineSmall?.fontSize ?? 24,
                fontWeight: FontWeight.normal,
              ),
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
                  Text(
                    'Cloudy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          Theme.of(context).textTheme.headlineLarge?.fontSize ??
                              32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.fontSize ??
                                16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'More',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Theme
                              .of(context)
                              .textTheme
                              .titleSmall
                              ?.fontSize ??
                              14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
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
                      Text(
                        'Min: 18°',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.fontSize ??
                              22,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        '20°',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.fontSize ??
                              32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Max: 25°',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.fontSize ??
                              22,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
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
