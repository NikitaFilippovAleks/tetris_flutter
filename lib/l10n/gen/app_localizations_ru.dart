// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get bestResults => 'Лучшие результаты';

  @override
  String get blocksSelector => 'Выбор блоков';

  @override
  String greetingUser(Object username) {
    return 'Добро пожаловать, $username!';
  }

  @override
  String get settings => 'Настройки';

  @override
  String get language => 'Язык';

  @override
  String get level => 'Уровень';

  @override
  String get english => 'Английский';

  @override
  String get russian => 'Русский';

  @override
  String get score => 'Очки';

  @override
  String get startGame => 'Начать игру';

  @override
  String get signOut => 'Выйти из аккаунта';

  @override
  String get username => 'Имя пользователя';

  @override
  String yourBestResult(Object score) {
    return 'Ваш лучший результат: $score';
  }
}
