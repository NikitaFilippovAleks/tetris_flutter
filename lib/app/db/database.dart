import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:tetris_flutter/features/user/data/local/users_table.dart';

/// Путь до файла, в котором будет сохраняться сгенерированный код
part 'database.g.dart';

@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1; /// Текущая версия базы данных
	
  ///Открытие соединения с базой данных  
  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'app_database'); // name – имя БД
  }
}
