// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get bestResults => 'Best Results';

  @override
  String get blocksSelector => 'Blocks selector';

  @override
  String greetingUser(Object username) {
    return 'Welcome, $username!';
  }

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get level => 'Level';

  @override
  String get english => 'English';

  @override
  String get russian => 'Russian';

  @override
  String get startGame => 'Start game';

  @override
  String get signOut => 'Sign out';

  @override
  String yourBestResult(Object score) {
    return 'Your best result: $score';
  }
}
