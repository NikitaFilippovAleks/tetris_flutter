import 'package:drift/drift.dart';
import 'package:tetris_flutter/app/db/database.dart';
import 'package:tetris_flutter/features/leaderboard/domain/leaderboard_entity.dart';

class LeaderboardLocalRepo {
  final AppDatabase _database;

  LeaderboardLocalRepo(this._database);

  Future<void> saveLeaderboard(List<LeaderboardEntity> leaderboard) async {
    await _database.batch((batch) {
      // Сначала удаляем все существующие записи
      batch.deleteAll(_database.leaderboard);

      // Затем вставляем новые данные
      batch.insertAll(
          _database.leaderboard,
          leaderboard.map((e) => LeaderboardCompanion(
                id: Value(e.id),
                name: Value(e.username),
                score: Value(e.score),
              )),
          mode: InsertMode.insert);
    });
  }

  Future<List<LeaderboardEntity>> getLeaderboard() async {
    final leaderboard = await _database.select(_database.leaderboard).get();
    return leaderboard
        .map((e) => LeaderboardEntity(
              id: e.id,
              username: e.name,
              score: e.score,
            ))
        .toList();
  }

  Future<void> clearLeaderboard() async {
    await _database.delete(_database.leaderboard).go();
  }
}
