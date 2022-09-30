import 'package:flutter/material.dart';

const String settingsScreenRoute = '/settings';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            activeColor: Colors.white,
            value: false,
            onChanged: (value) {},
            title: const Text('Use metric system'),
          )
        ],
      ),
    );
  }
}
