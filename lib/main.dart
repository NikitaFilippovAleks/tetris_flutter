import 'package:flutter/material.dart';
import 'package:tetris_flutter/app/di_container.dart';
import 'package:tetris_flutter/app/game_router.dart';
import 'package:tetris_flutter/features/leaderboard/presentation/leaderboard_screen.dart';
import 'package:tetris_flutter/models/settings_model.dart';
import 'package:tetris_flutter/features/game/game_over_screen.dart';
import 'package:tetris_flutter/features/game/game_screen.dart';
import 'package:tetris_flutter/features/settings/settings_screen.dart';

import 'features/main_menu/main_menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DiContainer(
      child: SettingsProvider(
        notifier: SettingsModel(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: GameRouter.initialRoute,
            routes: GameRouter.appRoutes,
        ),
      ),
    );
  }
}
