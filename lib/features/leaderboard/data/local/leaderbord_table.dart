import 'package:drift/drift.dart';

class Leaderboard extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  IntColumn get score => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
