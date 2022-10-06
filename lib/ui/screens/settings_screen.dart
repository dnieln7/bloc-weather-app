import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/state/settings/settings_cubit.dart';

const String settingsScreenRoute = '/settings';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
                  activeColor: Colors.white,
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
