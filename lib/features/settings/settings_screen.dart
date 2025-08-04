import 'package:flutter/material.dart';
import 'package:tetris_flutter/features/settings/widgets/blocks_selector/blocks_selector.dart';
import 'package:tetris_flutter/features/settings/widgets/level_selector.dart';
import 'package:tetris_flutter/l10n/gen/app_localizations.dart';
import 'package:tetris_flutter/models/settings_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsModel = SettingsProvider.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LevelSelector(
                level: settingsModel.level,
                onLevelChanged: (int level) {
                  settingsModel.setLevel(level);
                },
              ),
              const SizedBox(height: 20),
              const BlocksSelector(),
            ],
          ),
        ),
      ),
    );
  }
}
