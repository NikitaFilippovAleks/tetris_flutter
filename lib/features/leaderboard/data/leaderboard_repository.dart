import 'dart:convert';

import 'package:tetris_flutter/app/http/i_http_client.dart';
import 'package:tetris_flutter/features/leaderboard/data/local/leaderboard_local_repo.dart';

import '../domain/i_leaderboard_repository.dart';
import '../domain/leaderboard_entity.dart';
import 'leaderboard_dto.dart';

///  Реализация репозитория для таблицы лидеров
final class LeaderboardRepository implements ILeaderboardRepository {
  /// HTTP клиент для отправки запросов к API
  final IHttpClient httpClient;
  final LeaderboardLocalRepo leaderboardLocalRepo;

  LeaderboardRepository({required this.httpClient, required this.leaderboardLocalRepo});

  @override
  Future<Iterable<LeaderboardEntity>> fetchLeaderboard() async {
    try {
      final response = await httpClient.get('/users/');
      // Получение данных
      // Проверка статуса ответа
      if (response.statusCode != 200) {
        // throw Exception('Ошибка при загрузке: ${response.statusCode}');

        print('Ошибка при загрузке: ${response.statusCode}');
      } else {
        final Iterable data = json.decode(response.body);
        // Преобразование данных в список сущностей
        final leaderboard = data.map((item) {
          return LeaderboardDto.fromJson(item).toEntity();
        }).toList();

        // Кеширование данных
         await leaderboardLocalRepo.saveLeaderboard(leaderboard);
      }

    } catch (e) {
      print('Ошибка при загрузке: $e');
    }
    
    return await leaderboardLocalRepo.getLeaderboard();
  }
}
