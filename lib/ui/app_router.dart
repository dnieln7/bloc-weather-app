import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/repositories.dart';
import 'package:weather_app/state/settings/settings_cubit.dart';
import 'package:weather_app/ui/screens/screens.dart';

class AppRouter {
  Route<Object?>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreenRoute:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case settingsScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SettingsCubit>(
            create: (ctx) => SettingsCubit(
              settingsRepository: context.read<SettingsRepository>(),
            ),
            child: const SettingsScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
