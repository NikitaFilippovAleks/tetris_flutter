import 'package:flutter/material.dart';
import 'package:tetris_flutter/app/context_ext.dart';
import 'package:tetris_flutter/app/game_router.dart';
import 'package:tetris_flutter/l10n/gen/app_localizations.dart';

import '../../domain/user_entity.dart';

/// Компонент для отображения данных пользователя
/// при успешном создании
/// [userEntity] - сущность пользователя
class UserCreated extends StatelessWidget {
  const UserCreated({
    super.key,
    required this.userEntity,
  });

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l10n.greetingUser(userEntity.username)),
        const SizedBox(height: 16),
        Text(l10n.yourBestResult(userEntity.score)),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Переход на экран игры
            // при нажатии на кнопку "Начать игру"
            Navigator.pushReplacementNamed(
              context,
              GameRouter.gameRoute,
            );
          },
          child: Text(l10n.startGame),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Выход из аккаунта
            context.di.userCubit.signOut();
          },
          child: Text(l10n.signOut),
        ),
      ],
    );
  }
}
