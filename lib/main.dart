import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_app/data/api/position_stack_api.dart';
import 'package:weather_app/data/api/weather_api.dart';
import 'package:weather_app/data/preferences/preferences.dart';
import 'package:weather_app/data/repository/repositories.dart';
import 'package:weather_app/env/app_env.dart';
import 'package:weather_app/state/weather/weather_cubit.dart';
import 'package:weather_app/ui/app_router.dart';
import 'package:weather_app/ui/screens/screens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  final AppEnv appEnv = AppEnv();
  final AppRouter _router = AppRouter();
  final AppPreferences _preferences = AppPreferences();
  final WeatherApi _weatherApi = WeatherApi();

  WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (ctx) => SettingsRepository(preferences: _preferences),
        ),
        RepositoryProvider(
          create: (ctx) => LocationRepository(
            positionStackApi: PositionStackApi(
              url: appEnv.positionStackApiURL,
              key: appEnv.positionStackApiKey,
            ),
          ),
        ),
        RepositoryProvider(
          create: (ctx) => WeatherRepository(
            preferences: _preferences,
            weatherApi: _weatherApi,
          ),
        ),
      ],
      child: BlocProvider<WeatherCubit>(
        create: (ctx) => WeatherCubit(
          locationRepository: ctx.read<LocationRepository>(),
          weatherRepository: ctx.read<WeatherRepository>(),
        ),
        child: MaterialApp(
          title: 'Weather app',
          theme: theme,
          initialRoute: homeScreenRoute,
          onGenerateRoute: _router.onGenerateRoute,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      ),
    );
  }

  ThemeData get theme {
    return ThemeData.dark().copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.windows: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.fuchsia: OpenUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
