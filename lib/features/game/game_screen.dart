import 'package:flutter/material.dart';
import 'package:tetris_flutter/main.dart';
import 'package:tetris_flutter/models/settings_model.dart';

import 'tetris_game.dart';

class GameScreen extends StatelessWidget {
  // final int level;
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsModel = SettingsProvider.of(context);
    final currentLocale = Localizations.localeOf(context).languageCode;
    final languageCode = currentLocale == 'en' ? 'ru' : 'en';

    return Scaffold(
      body: TetrisGame(
        level: settingsModel.level,
        activeBlocks: settingsModel.activeBlocks,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(currentLocale),
          IconButton(
            onPressed: () {
              // Ищем ближайший к текущему контексту экземпляр класса
              // [MyAppState] и вызываем у него метод [setLocale],
              // чтобы изменить язык.
              final state = context.findAncestorStateOfType<MyAppState>();
              if (state != null) {
                state.setLocale(Locale(languageCode));
              }
            },
            icon: const Icon(Icons.language),
          ),
        ],
      ),
    );
  }
}
