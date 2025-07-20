import 'package:flutter/material.dart';
import 'package:tetris_flutter/models/settings_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsModel = SettingsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text('Level: ${settingsModel.level}'),
            Slider(
              min: 1,
              max: 5,
              value: settingsModel.level.toDouble(),
              label: settingsModel.level.toString(),
              onChanged: (double value) {
                settingsModel.setLevel(value.toInt());
              },
            ),
          ],
        ),
      ),
    );
  }
}
