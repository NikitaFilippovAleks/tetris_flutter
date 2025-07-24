

//  Роутер игры.
import 'package:flutter/widgets.dart';
import 'package:tetris_flutter/features/game/game_screen.dart';
import 'package:tetris_flutter/features/game/game_over_screen.dart';
import 'package:tetris_flutter/features/leaderboard/presentation/leaderboard_screen.dart';
import 'package:tetris_flutter/features/main_menu/main_menu_screen.dart';
import 'package:tetris_flutter/features/settings/settings_screen.dart';
import 'package:tetris_flutter/features/user/presentation/user_screen.dart';

abstract final class GameRouter {
  // Начальный маршрут.
  static const String initialRoute = '/';

  // Маршрут игры
  static const String gameRoute = '/game';

  // Маршрут окончания игры
  static const String gameOverRoute = '/game_over';

  // Маршрут настроек
  static const String settingsRoute = '/settings';

  // Маршрут таблицы лидеров
  static const String leaderboardRoute = '/leaderboard';

  // Маршрут создания пользователя
  static const String userRoute = '/user';

  // Маршруты приложения. Объявляются приватными, чтобы 
  // исключить к ним доступ вне навигатора
  static final Map<String, WidgetBuilder> appRoutes = {
    // Рутовый экран - главное меню
    initialRoute: (_) => const MainMenuScreen(),
    // Экран игры
    gameRoute: (_) => const GameScreen(),
    // Экран окончания игры
    gameOverRoute: (_) => const GameOverScreen(),
    // Экран настроек
    settingsRoute: (_) => const SettingsScreen(),
    // Экран таблицы лидеров
    leaderboardRoute: (_) => const LeaderboardScreen(),
    // Экран создания пользователя
    userRoute: (_) => const UserScreen(),
  };
}
