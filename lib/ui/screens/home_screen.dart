import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/enums/enums.dart';
import 'package:weather_app/state/weather/weather_cubit.dart';
import 'package:weather_app/ui/screens/screens.dart';
import 'package:weather_app/ui/widgets/animated/animated.dart';
import 'package:weather_app/ui/widgets/style/color_styles.dart';
import 'package:weather_app/ui/widgets/style/insets_styles.dart';
import 'package:weather_app/ui/widgets/style/text_styles.dart';
import 'package:weather_app/ui/widgets/weather/weather.dart';

const String homeScreenRoute = '/';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final bool searching = true;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return BlocBuilder<WeatherCubit, WeatherFetchState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: state is WeatherFetchLoading
                ? loadingIndicator(context)
                : Container(),
            actions: menuActions(context, state),
          ),
          body: state is WeatherFetchSuccess
              ? weatherUi(context, orientation, state)
              : state is WeatherFetchError
                  ? errorUi(context, orientation, state)
                  : emptyBody,
        );
      },
    );
  }

  List<Widget> menuActions(BuildContext context, WeatherFetchState state) {
    return [
      if (state is WeatherFetchSuccess || state is WeatherFetchError)
        IconButton(
          onPressed: context.read<WeatherCubit>().refresh,
          icon: const Icon(Icons.refresh_rounded),
        ),
      IconButton(
        onPressed: () => Navigator.of(context).pushNamed(settingsScreenRoute),
        icon: const Icon(Icons.settings_rounded),
      ),
    ];
  }

  Widget weatherUi(
    BuildContext context,
    Orientation orientation,
    WeatherFetchSuccess state,
  ) {
    return Container(
      padding: InsetsStyles.globalPadding(context, orientation),
      decoration: BoxDecoration(
        gradient: ColorStyles.getTemperatureGradient(
          state.weather.temperatureType,
        ),
      ),
      child: orientation == Orientation.portrait
          ? Column(
              children: [
                WeatherLocation(city: state.location.locality),
                const SizedBox(height: 20),
                Expanded(
                  child: WeatherSummary(
                    weatherType: state.weather.weatherType,
                    orientation: Orientation.portrait,
                  ),
                ),
                TemperatureSummary(
                  max: state.weather.maxTemperature,
                  current: state.weather.temperature,
                  min: state.weather.minTemperature,
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherLocation(city: state.location.locality),
                    WeatherSummary(
                      weatherType: state.weather.weatherType,
                      orientation: Orientation.landscape,
                    ),
                  ],
                ),
                TemperatureSummary(
                  max: state.weather.maxTemperature,
                  current: state.weather.temperature,
                  min: state.weather.minTemperature,
                )
              ],
            ),
    );
  }

  Widget errorUi(
    BuildContext context,
    Orientation orientation,
    WeatherFetchError state,
  ) {
    return Container(
      alignment: Alignment.center,
      padding: InsetsStyles.globalPadding(context, orientation),
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

  Widget get emptyBody {
    return Container(
      decoration: BoxDecoration(
        gradient: ColorStyles.getTemperatureGradient(
          TemperatureType.none,
        ),
      ),
    );
  }

  Widget loadingIndicator(BuildContext context) {
    return BlinkingContainer(
      child: Text(
        'Loading ...',
        style: TextStyles.titleLarge(context),
      ),
    );
  }
}
