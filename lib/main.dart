import 'package:flutter/material.dart';
import 'package:tetris_flutter/models/settings_model.dart';
import 'package:tetris_flutter/screens/game_over_screen.dart';
import 'package:tetris_flutter/screens/game_screen.dart';
import 'package:tetris_flutter/screens/settings_screen.dart';

import 'screens/main_menu_screen.dart';

part 'game_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsProvider(
      notifier: SettingsModel(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: GameRouter.initialRoute,
          routes: GameRouter._appRoutes,
      ),
    );
  }
}
