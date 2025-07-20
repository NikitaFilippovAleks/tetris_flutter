import 'package:flutter/material.dart';
import 'package:tetris_flutter/models/settings_model.dart';

import '../tetris_game.dart';

class GameScreen extends StatelessWidget {
  // final int level;
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsModel = SettingsProvider.of(context);

    return Scaffold(
      body: TetrisGame(level: settingsModel.level),
    );
  }
}
