import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/enums/enums.dart';
import 'package:weather_app/state/settings/settings_cubit.dart';
import 'package:weather_app/ui/widgets/style/color_styles.dart';

const String settingsScreenRoute = '/settings';

class SettingsScreenArgs {
  final TemperatureType temperatureType;

  SettingsScreenArgs({required this.temperatureType});
}

class SettingsScreen extends StatelessWidget {
  final SettingsScreenArgs args;

  const SettingsScreen({
    Key? key,
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
        title: const Text('Settings'),
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
                  activeColor: ColorStyles.getTemperatureSolid(
                    args.temperatureType,
                  ),
                  value: state.settings.useMetricSystem,
                  onChanged: (value) {
                    context.read<SettingsCubit>().setMetricSystem(value);
                  },
                  title: const Text('Use metric system'),
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
