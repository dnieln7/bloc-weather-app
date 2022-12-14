import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_app/config/env.dart';
import 'package:weather_app/data/preferences/preferences.dart';
import 'package:weather_app/data/repository/repositories.dart';
import 'package:weather_app/data/server/server.dart';
import 'package:weather_app/state/weather/weather_cubit.dart';
import 'package:weather_app/ui/app_router.dart';
import 'package:weather_app/ui/screens/screens.dart';

void main() async {

  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  final Env _env = const Env();
  final AppRouter _router = AppRouter();
  final AppPreferences _preferences = AppPreferences();

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
            reverseLocationApi: ReverseLocationApi(
              url: _env.openStreetMapApiURL,
            ),
          ),
        ),
        RepositoryProvider(
          create: (ctx) => WeatherRepository(
            preferences: _preferences,
            weatherApi: WeatherApi(url: _env.openWeatherApiURL),
          ),
        ),
      ],
      child: BlocProvider<WeatherCubit>(
        create: (ctx) => WeatherCubit(
          locationRepository: ctx.read<LocationRepository>(),
          weatherRepository: ctx.read<WeatherRepository>(),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
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
