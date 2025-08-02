import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tetris_flutter/features/main_menu/main_menu_screen.dart';

void main() {
  group('Тестирование MainMenuScreen', () {
    testWidgets('Проверка создания MainMenuScreen', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: MainMenuScreen(),
      ));

      expect(find.text('Start Game'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Leaderboard'), findsOneWidget);
    });
  });
}
