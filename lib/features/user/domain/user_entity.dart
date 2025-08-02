import 'package:flutter/foundation.dart';
import 'package:tetris_flutter/app/equals_mixin.dart';

/// Сущность пользователя
@immutable
class UserEntity with EqualsMixin {
  /// Идентификатор пользователя
  final int id;

  /// Имя пользователя
  final String username;

  /// Лучший счет пользователя
  final int score;

  /// Флаг отправки данных на сервер
  final bool isSentToServer;

  const UserEntity({
    required this.id,
    required this.username,
    required this.score,
    required this.isSentToServer,
  });

  @override
  List<Object?> get fields => [id, username, score, isSentToServer];
} 
