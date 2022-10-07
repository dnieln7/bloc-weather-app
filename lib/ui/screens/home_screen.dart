import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/enums/enums.dart';
import 'package:weather_app/state/weather/weather_cubit.dart';
import 'package:weather_app/ui/screens/screens.dart';
import 'package:weather_app/ui/widgets/animated/animated.dart';
import 'package:weather_app/ui/widgets/style/color_styles.dart';
import 'package:weather_app/ui/widgets/style/text_styles.dart';
import 'package:weather_app/ui/widgets/weather/weather.dart';

const String homeScreenRoute = '/';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final bool searching = true;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

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
            onPressed: () => Navigator.of(context).pushNamed(
              settingsScreenRoute,
            ),
            icon: const Icon(Icons.settings_rounded),
          )
        ],
      ),
      body:BlocBuilder<WeatherCubit, WeatherFetchState>(
          builder: (ctx, state) {
            if (state is WeatherFetchSuccess) {
              return weatherUi(context, orientation, state);
            } else if (state is WeatherFetchError) {
              return errorUi(context, orientation, state);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
    );
  }

  EdgeInsets getPadding(BuildContext context, Orientation orientation) {
    double verticalMultiplier;
    double horizontalMultiplier;

    if (orientation == Orientation.portrait) {
      verticalMultiplier = 0.10;
      horizontalMultiplier = 0.05;
    } else {
      verticalMultiplier = 0.05;
      horizontalMultiplier = 0.02;
    }

    return EdgeInsets.symmetric(
      vertical: MediaQuery.of(context).size.height * verticalMultiplier,
      horizontal: MediaQuery.of(context).size.width * horizontalMultiplier,
    );
  }

  Widget weatherUi(
    BuildContext context,
    Orientation orientation,
    WeatherFetchSuccess state,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: ColorStyles.getTemperatureGradient(
          state.data.temperatureType,
        ),
      ),
      padding: getPadding(context, orientation),
      child: orientation == Orientation.portrait
          ? Column(
              children: [
                WeatherLocation(city: 'City'),
                const SizedBox(height: 20),
                Expanded(
                  child: WeatherSummary(
                    weatherType: state.data.weatherType,
                    orientation: Orientation.portrait,
                  ),
                ),
                TemperatureSummary(
                  max: state.data.maxTemperature,
                  current: state.data.temperature,
                  min: state.data.minTemperature,
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherLocation(city: 'City'),
                    WeatherSummary(
                      weatherType: state.data.weatherType,
                      orientation: Orientation.landscape,
                    ),
                  ],
                ),
                TemperatureSummary(
                  max: state.data.maxTemperature,
                  current: state.data.temperature,
                  min: state.data.minTemperature,
                )
              ],
            ),
    );
  }

  Widget errorUi(BuildContext context, Orientation orientation, WeatherFetchError state) {
    return Padding(
      padding: getPadding(context, orientation),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 100,
            color: Colors.white70,
          ),
          const SizedBox(height: 10),
          Text(
            'Error fetching current weather',
            textAlign: TextAlign.center,
            style: TextStyles.titleLarge(context),
          ),
          const SizedBox(height: 5),
          Text(
            state.error,
            textAlign: TextAlign.center,
            style: TextStyles.titleSmall(context),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: context.read<WeatherCubit>().refresh,
            child: Text('Try again'.toUpperCase()),
          )
        ],
      ),
    );
  }
}
