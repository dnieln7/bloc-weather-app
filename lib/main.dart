import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_app/data/api/weather_api.dart';
import 'package:weather_app/data/preferences/preferences.dart';
import 'package:weather_app/data/repository/repositories.dart';
import 'package:weather_app/state/weather/weather_cubit.dart';
import 'package:weather_app/ui/app_router.dart';
import 'package:weather_app/ui/screens/screens.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
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
          create: (ctx) => LocationRepository(),
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
          supportedLocales: locales,
          localizationsDelegates: localizationsDelegates,
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

  List<Locale> get locales {
    return const [Locale('en'), Locale('es')];
  }

  List<LocalizationsDelegate<dynamic>> get localizationsDelegates {
    return const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }
}
