import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:tetris_flutter/features/leaderboard/data/local/leaderbord_table.dart';
import 'package:tetris_flutter/features/user/data/local/users_table.dart';

/// Путь до файла, в котором будет сохраняться сгенерированный код
part 'database.g.dart';

@DriftDatabase(tables: [Users, Leaderboard])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  /// Текущая версия базы данных

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Добавляем таблицу leaderboard если её нет
          await m.createTable(leaderboard);
        }
      },
    );
  }

  ///Открытие соединения с базой данных
  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'app_database'); // name – имя БД
  }
}
