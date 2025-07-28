import 'package:flutter/material.dart';
import 'package:tetris_flutter/app/di/depends.dart';
import 'package:tetris_flutter/app/di/di_container.dart';
import 'package:tetris_flutter/app/game_router.dart';
import 'package:tetris_flutter/features/leaderboard/presentation/leaderboard_screen.dart';
import 'package:tetris_flutter/models/settings_model.dart';
import 'package:tetris_flutter/features/game/game_over_screen.dart';
import 'package:tetris_flutter/features/game/game_screen.dart';
import 'package:tetris_flutter/features/settings/settings_screen.dart';

import 'features/main_menu/main_menu_screen.dart';

void main() async {
  // Инициализируем Flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  // Создаем экземпляр класса Depends
  final Depends depends = Depends();
  try {
    // Инициализируем зависимости
    await depends.init();
    // В случае успешной инициализации зависимостей
    // запускаем приложение
    // Передаем зависимости в контейнер зависимостей
    runApp(MyApp(
      depends: depends,
    ));
  } on Object catch (error, stackTrace) {
    // В случае ошибки при инициализации зависимостей
    // запускаем приложение с экраном ошибки
    runApp(AppError(
      error: error,
      stackTrace: stackTrace,
    ));
  }
}

/// Экран ошибки приложения
class AppError extends StatelessWidget {
  const AppError({
    super.key,
    required this.error,
    required this.stackTrace,
  });

  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Произошла ошибка:'),
              Text(error.toString()),
              Text(stackTrace.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.depends});

  final Depends depends;

  @override
  Widget build(BuildContext context) {
    return DiContainer(
      depends: depends,
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
