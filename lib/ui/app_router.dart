import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/repositories.dart';
import 'package:weather_app/state/settings/settings_cubit.dart';
import 'package:weather_app/ui/screens/screens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

class AppRouter {
  Route<Object?>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreenRoute:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(
            localizations: getLocalizations(context),
          ),
        );
      case settingsScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SettingsCubit>(
            create: (ctx) => SettingsCubit(
              settingsRepository: context.read<SettingsRepository>(),
            ),
            child: SettingsScreen(
              localizations: getLocalizations(context),
              args: settings.arguments as SettingsScreenArgs,
            ),
          ),
        );
      default:
        return null;
    }
  }

  AppLocalizations getLocalizations(BuildContext context) {
    return AppLocalizations.of(context) ?? AppLocalizationsEn();
  }
}
