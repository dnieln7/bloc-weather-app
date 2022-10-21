import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/enum/enums.dart';
import 'package:weather_app/state/settings/settings_cubit.dart';
import 'package:weather_app/ui/widgets/style/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String settingsScreenRoute = '/settings';

class SettingsScreenArgs {
  final TemperatureType temperatureType;

  SettingsScreenArgs({required this.temperatureType});
}

class SettingsScreen extends StatelessWidget {

  final AppLocalizations localizations;
  final SettingsScreenArgs args;

  const SettingsScreen({
    Key? key,
    required this.localizations,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SettingsCubit>().getSettings();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(localizations.settings),
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (ctx, state) {
          if (state is SettingsLoaded && state.errorUpdating != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorUpdating!)),
            );
          }
        },
        builder: (ctx, state) {
          if (state is SettingsLoaded) {
            return Column(
              children: [
                SwitchListTile(
                  activeColor: AppColors.getTemperatureSolid(
                    args.temperatureType,
                  ),
                  value: state.settings.useMetricSystem,
                  onChanged: (value) {
                    context.read<SettingsCubit>().setMetricSystem(value);
                  },
                  title: Text(localizations.useMetricSystem),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
