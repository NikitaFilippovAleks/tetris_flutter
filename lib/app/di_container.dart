import 'package:flutter/widgets.dart';
import 'package:tetris_flutter/app/http/base_http_client.dart';
import 'package:tetris_flutter/app/http/i_http_client.dart';
import 'package:tetris_flutter/features/leaderboard/data/leaderboard_repository.dart';
import 'package:tetris_flutter/features/leaderboard/domain/i_leaderboard_repository.dart';
import 'package:tetris_flutter/features/user/data/user_repository.dart';
import 'package:tetris_flutter/features/user/domain/i_user_repository.dart';
import 'package:tetris_flutter/features/user/domain/state/user_cubit.dart';

final class DiContainer extends InheritedWidget {
  DiContainer({super.key, required super.child}) {
    // Инициализируем контейнер зависимостей
    _httpClient = BaseHttpClient();

    leaderboardRepository = LeaderboardRepository(httpClient: _httpClient);
    _userRepository = UserRepository(httpClient: _httpClient);
    userCubit = UserCubit(repository: _userRepository);
  }

  late final IHttpClient _httpClient;

  late final ILeaderboardRepository leaderboardRepository;
  late final IUserRepository _userRepository;
  late final UserCubit userCubit;

  /// Так как контейнер зависимостей нужен только для доступа 
  /// к зависимостям – возвращаем false, чтобы виджеты-потомки 
  /// не перестраивались при изменении контекста 
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;


  /// Получение контейнера зависимостей из контекста
  static DiContainer of(BuildContext context) {
    // Ищем контейнер зависимостей в контексте
    // Если не нашли, то выбрасываем исключение
    final DiContainer? container =
        context.getInheritedWidgetOfExactType<DiContainer>();
    if (container == null) {
      throw Exception('Контейнер зависимостей не найден в контексте');
    }
    return container;
  }
}
