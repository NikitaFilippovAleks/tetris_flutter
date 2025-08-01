import 'package:drift/drift.dart';
import 'package:tetris_flutter/app/db/database.dart';
import 'package:tetris_flutter/features/user/domain/user_entity.dart';

class UserLocalRepo {
  final AppDatabase _database;

  UserLocalRepo(this._database);

  Future<void> saveUser(UserEntity user) async {
    await _database.into(_database.users).insertOnConflictUpdate(UsersCompanion(
          id: const Value(1),
          name: Value(user.username),
          score: Value(user.score),
        ));
  }

  Future<UserEntity?> getUser() async {
    final user = await _database.select(_database.users).getSingleOrNull();
    if (user == null) {
      return null;
    }
    return UserEntity(
      id: user.id,
      username: user.name,
      score: user.score,
    );
  }

  Future<void> clearUser() async {
    await _database.delete(_database.users).go();
  }
}
