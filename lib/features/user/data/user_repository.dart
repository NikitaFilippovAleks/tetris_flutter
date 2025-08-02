import 'dart:convert';

import 'package:tetris_flutter/app/http/i_http_client.dart';
import 'package:tetris_flutter/features/user/data/local/user_local_repo.dart';

import '../domain/i_user_repository.dart';
import '../domain/user_entity.dart';
import 'user_dto.dart';

/// Репозиторий для работы с пользователем
final class UserRepository implements IUserRepository {
  final IHttpClient httpClient;
  final UserLocalRepo userLocalRepo;

  UserRepository({required this.httpClient, required this.userLocalRepo});

  @override
  Future<UserEntity> createUser(String username) async {
    // JSON-данные c отложенной инициализацией
    // Получаем данные от сервера или создаем пользователя
    // с id = 0 и score = 0
    late final Map<String, dynamic> resultJson;
    var isSentToServer = false;

    // Получение данных
    try {
      final response = await httpClient.post(
        '/users/',
        body: {"username": username},
      );
      // Проверка статуса ответа
      if (response.statusCode != 200) {
        throw Exception(
          'Ошибка при создании пользователя: ${response.statusCode}',
        );
      }
      resultJson = json.decode(response.body);
      isSentToServer = true;
    } on Object catch (_) {
      print('Error: $_');
      // Если произошла ошибка, то создаем пользователя
      // с id = 0 и score = 0 и сохраняем его в локальном хранилище
      resultJson = {
        'id': 0,
        'username': username,
        'score': 0,
      };
    }
    final userDto = UserDto.fromJson(resultJson);
    // Сохранение пользователя в локальном хранилище
    await userLocalRepo.saveUser(userDto.toEntity(isSentToServer));
    // Преобразование данных в список сущностей
    final savedUser = await userLocalRepo.getUser();
    return savedUser!;
  }

  @override
  Future<UserEntity> setScores(String username, int scores) async {
    // JSON-данные c отложенной инициализацией
    // Получаем данные от сервера или создаем пользователя
    // с id = 0 и score = 0
    late final Map<String, dynamic> resultJson;
    var isSentToServer = false;

    try {
      final response = await httpClient.put(
        '/users/scores/',
        body: {
          'username': username,
          'score': scores,
        },
      );
      // Проверка статуса ответа
      if (response.statusCode != 200) {
        throw Exception(
          'Ошибка при обновлении пользователя: ${response.statusCode}',
        );
      }
      resultJson = json.decode(response.body);
      isSentToServer = true;
    } on Object catch (_) {
      // Если произошла ошибка, то
      // сохраняем его в локальном хранилище
      resultJson = {
        'id': 0,
        'username': username,
        'score': scores,
      };
    }
    final userDto = UserDto.fromJson(resultJson);
    // Сохранение пользователя в локальном хранилище
    await userLocalRepo.saveUser(userDto.toEntity(isSentToServer));
    // Преобразование данных в список сущностей
    final savedUser = await userLocalRepo.getUser();
    return savedUser!;
  }

  createUserFromLocalStorage() async {
    final user = await userLocalRepo.getUser();
    late final Map<String, dynamic> resultJson;
    var isSentToServer = false;

    // Получение данных
    try {
      final response = await httpClient.post(
        '/users/',
        body: {"username": user?.username, "score": user?.score},
      );
      // Проверка статуса ответа
      if (response.statusCode != 200) {
        throw Exception(
          'Ошибка при создании пользователя: ${response.statusCode}',
        );
      }
      resultJson = json.decode(response.body);
      isSentToServer = true;
    } on Object catch (_) {
      print('Error: $_');
      // Если произошла ошибка, то создаем пользователя
      // с id = 0 и score = 0 и сохраняем его в локальном хранилище
      resultJson = {
        'id': 0,
        'username': user?.username,
        'score': user?.score,
      };
    }
    final userDto = UserDto.fromJson(resultJson);
    // Сохранение пользователя в локальном хранилище
    await userLocalRepo.saveUser(userDto.toEntity(isSentToServer));
    // Преобразование данных в список сущностей
    final savedUser = await userLocalRepo.getUser();
    return savedUser!;
  }

  @override
  Future<void> deleteUserFromStorage() async {
    // Очистка локального хранилища
    await userLocalRepo.clearUser();
  }

  @override
  Future<UserEntity?> getUserFromStorage() async {
    // Получение данных из локального хранилища
    final user = await userLocalRepo.getUser();

    // Преобразование данных в JSON
    return user;
  }
}
