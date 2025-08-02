import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tetris_flutter/app/di/di_container.dart';
import 'package:tetris_flutter/features/user/domain/i_user_repository.dart';
import 'package:tetris_flutter/features/user/domain/state/user_cubit.dart';
import 'package:tetris_flutter/features/user/domain/user_entity.dart';
import 'package:tetris_flutter/features/user/presentation/user_screen.dart';

import '../../../test/features/user/user_screen_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Тестирование UserScreen', () {
    late IUserRepository repository;
    late UserCubit userCubit;
    late MockDepends mockDepends;

    setUp(() {
      repository = MockIUserRepository();
      when(repository.getUserFromStorage()).thenAnswer((_) async => null);
      when(repository.createUser('test_user'))
          .thenAnswer((_) async => const UserEntity(
                id: 1,
                username: 'test_user',
                score: 0,
                isSentToServer: false,
              ));
      when(repository.createUserFromLocalStorage())
          .thenAnswer((_) async => const UserEntity(
                id: 1,
                username: 'test_user',
                score: 0,
                isSentToServer: false,
              ));
      when(repository.setScores('test_user', 100))
          .thenAnswer((_) async => const UserEntity(
                id: 1,
                username: 'test_user',
                score: 100,
                isSentToServer: true,
              ));
      when(repository.deleteUserFromStorage()).thenAnswer((_) async {});
      userCubit = UserCubit(repository: repository);
      mockDepends = MockDepends();
      when(mockDepends.userCubit).thenReturn(userCubit);
    });

    testWidgets('Проверка создания UserScreen с инициализационным состоянием',
        (tester) async {
      await tester.pumpWidget(DiContainer(
        depends: mockDepends,
        child: const MaterialApp(
          home: UserScreen(),
        ),
      ));

      expect(find.text('Введите ваш никнейм:'), findsOneWidget);
      expect(find.text('Создать пользователя'), findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      final inputField = find.byType(TextField);
      await tester.enterText(inputField, 'test_user');
      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.text('Создать пользователя'));
      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));
      expect(find.text('Добро пожаловать, test_user!'), findsOneWidget);
    });
  });
}
