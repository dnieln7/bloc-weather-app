import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_app/domain/enum/enums.dart';
import 'package:weather_app/state/weather/weather_cubit.dart';
import 'package:weather_app/ui/screens/screens.dart';
import 'package:weather_app/ui/widgets/animated/blinking_container.dart';
import 'package:weather_app/ui/widgets/style/app_colors.dart';
import 'package:weather_app/ui/widgets/style/app_insets.dart';
import 'package:weather_app/ui/widgets/style/app_texts.dart';
import 'package:weather_app/ui/widgets/weather/temperature_summary.dart';
import 'package:weather_app/ui/widgets/weather/weather_location.dart';
import 'package:weather_app/ui/widgets/weather/weather_summary.dart';

const String homeScreenRoute = '/';

class HomeScreen extends StatelessWidget {
  final AppLocalizations localizations;

  const HomeScreen({Key? key, required this.localizations}) : super(key: key);

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
    final TemperatureType temperatureType;

    if (state is WeatherFetchSuccess) {
      temperatureType = state.weather.temperatureType;
    } else {
      temperatureType = TemperatureType.none;
    }

    if (state is WeatherFetchSuccess || state is WeatherFetchError) {
      return [
        IconButton(
          onPressed: context.read<WeatherCubit>().refresh,
          icon: const Icon(Icons.refresh_rounded),
          tooltip: localizations.refresh,
        ),
        IconButton(
          onPressed: () => {
            Navigator.of(context)
                .pushNamed(
                  settingsScreenRoute,
                  arguments:
                      SettingsScreenArgs(temperatureType: temperatureType),
                )
                .then((value) => context.read<WeatherCubit>().refresh())
                .catchError((error) {})
          },
          icon: const Icon(Icons.settings_rounded),
          tooltip: localizations.settings,
        ),
      ];
    } else {
      return [];
    }
  }

  Widget weatherUi(
    BuildContext context,
    Orientation orientation,
    WeatherFetchSuccess state,
  ) {
    return Container(
      padding: AppInsets.globalPadding(context, orientation),
      decoration: BoxDecoration(
        gradient: AppColors.getTemperatureGradient(
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
                    localizations: localizations,
                    weatherType: state.weather.weatherType,
                    orientation: Orientation.portrait,
                  ),
                ),
                TemperatureSummary(
                  localizations: localizations,
                  max: state.weather.maxTemperature,
                  current: state.weather.temperature,
                  min: state.weather.minTemperature,
                  useMetricSystem: state.weather.useMetricSystem,
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 50,
                      fit: FlexFit.tight,
                      child: WeatherLocation(city: state.location.locality),
                    ),
                    Flexible(
                      flex: 50,
                      fit: FlexFit.tight,
                      child: WeatherSummary(
                        localizations: localizations,
                        weatherType: state.weather.weatherType,
                        orientation: Orientation.landscape,
                      ),
                    ),
                  ],
                ),
                TemperatureSummary(
                  localizations: localizations,
                  max: state.weather.maxTemperature,
                  current: state.weather.temperature,
                  min: state.weather.minTemperature,
                  useMetricSystem: state.weather.useMetricSystem,
                ),
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
      padding: AppInsets.globalPadding(context, orientation),
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
            localizations.errorFetchingCurrentWeather,
            textAlign: TextAlign.center,
            style: AppTexts.titleLarge(context),
          ),
          const SizedBox(height: 5),
          Text(
            state.error,
            textAlign: TextAlign.center,
            style: AppTexts.titleSmall(context),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: context.read<WeatherCubit>().refresh,
            child: Text(localizations.tryAgain.toUpperCase()),
          )
        ],
      ),
    );
  }

  Widget get emptyBody {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.getTemperatureGradient(
          TemperatureType.none,
        ),
      ),
    );
  }

  Widget loadingIndicator(BuildContext context) {
    return BlinkingContainer(
      child: Text(
        localizations.loading,
        style: AppTexts.titleLarge(context),
      ),
    );
  }
}
