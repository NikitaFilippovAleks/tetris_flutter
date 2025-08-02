import 'dart:async';

import 'package:flutter/foundation.dart';

import '../i_user_repository.dart';
import 'user_state.dart';

/// Класс для управления состоянием пользователя
/// и взаимодействия с удаленным репозиторием
class UserCubit {
  final IUserRepository repository;
  final StreamController<bool> isSentToServerStreamController =
      StreamController<bool>();

  UserCubit({required this.repository}) {
    isSentToServerStreamController.stream.listen((isSentToServer) async {
      if (!isSentToServer) {
        await Future.delayed(const Duration(seconds: 2), () async {
          final localUser = await repository.getUserFromStorage();
          if (localUser != null) {
            final entity = await repository.createUserFromLocalStorage();
            print('entity.isSentToServer: ${entity.isSentToServer}');
            isSentToServerStreamController.add(entity.isSentToServer);
          }
        });
      }
    });

    checkIsSentToServer();
  }

  final ValueNotifier<UserState> stateNotifier =
      ValueNotifier(const UserInitState());
  

  checkIsSentToServer() async {
    print('checkIsSentToServer');
    final localUser = await repository.getUserFromStorage();
    if (localUser != null) {
      isSentToServerStreamController.add(localUser.isSentToServer);
    }
  }

  Future<void> createUser(String username) async {
    // Проверка состояния, если состояние загрузки, то не выполнять запрос
    // и не перезаписывать состояние
    if (stateNotifier.value is UserLoadingState) return;

    try {
      // Установка состояния загрузки
      emit(const UserLoadingState());
      // Создание пользователя
      // Если пользователь с таким именем уже существует,
      final entity = await repository.createUser(username);
      isSentToServerStreamController.add(entity.isSentToServer);
      // Установка состояния успешной загрузки
      // и передача сущности пользователя
      emit(UserSuccessState(entity));
    } on Object catch (error, stackTrace) {
      print('Error: $error');
      print('Stack trace: $stackTrace');
      // Установка состояния ошибки
      // и передача сообщения об ошибке
      emit(UserErrorState('Ошибка создания пользователя',
          error: error, stackTrace: stackTrace));
    }
  }

  /// Установка счета пользователя
  /// [username] - имя пользователя
  /// [scores] - счет пользователя
  Future<void> setScores(String username, int scores) async {
    if (stateNotifier.value is UserLoadingState) return;

    try {
      emit(const UserLoadingState());
      final entity = await repository.setScores(username, scores);
      isSentToServerStreamController.add(entity.isSentToServer);
      emit(UserSuccessState(entity));
    } on Object catch (error, stackTrace) {
      emit(UserErrorState(
        'Ошибка обновления результата пользователя',
        error: error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Выход из аккаунта
  /// Удаление текущего состояния
  void signOut() {
    // Очищаем состояние пользователя
    repository.deleteUserFromStorage();
    emit(const UserInitState());
  }

  /// Сброс состояния кубита
  /// Пригодится для сброса состояния
  /// при повторном входе в аккаунт
  void reset() {
    // Очищаем состояние пользователя
    repository.deleteUserFromStorage();
    emit(const UserInitState());
  }

  /// Установка текущего состояния
  void emit(UserState cubitState) {
    stateNotifier.value = cubitState;
  }

  /// Получение пользователя из локального хранилища
  /// Если пользователь найден, то устанавливаем состояние
  /// успешной загрузки и передаем сущность пользователя
  Future<void> restoreUser() async {
    try {
      // Получение пользователя из локального хранилища
      final entity = await repository.getUserFromStorage();
      if (entity != null) {
        // Установка состояния успешной загрузки
        // и передача сущности пользователя
        emit(UserSuccessState(entity));
      }
    } on Object catch (_) {
      emit(const UserInitState());
    }
  }
}
