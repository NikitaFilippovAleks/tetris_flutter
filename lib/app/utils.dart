import 'package:flutter/widgets.dart';
import 'package:tetris_flutter/app/context_ext.dart';

import '../features/user/domain/state/user_state.dart';

/// Утилита для работы с приложением
/// Содержит методы, которые могут быть полезны в его разных частях
abstract class Utils {
  // Получаем имя пользователя из состояния кубита
  // Если состояние кубита - успешная загрузка,
  // то возвращаем имя пользователя
  // Если любое другое состояние, то возвращаем 'Гость'
  static String getUsername(
    BuildContext context,
  ) {
    final state = context.di.userCubit.stateNotifier.value;
    if (state is UserSuccessState) {
      return state.userEntity.username;
    } else {
      return 'Гость';
    }
  }
}
