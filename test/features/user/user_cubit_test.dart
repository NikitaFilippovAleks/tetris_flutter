import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tetris_flutter/features/user/domain/i_user_repository.dart';
import 'package:tetris_flutter/features/user/domain/state/user_cubit.dart';
import 'package:tetris_flutter/features/user/domain/state/user_state.dart';
import 'package:tetris_flutter/features/user/domain/user_entity.dart';

import 'user_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IUserRepository>()])
Future<void> main() async {
  late IUserRepository repository;
  late UserCubit cubit;

  setUp(() {
    repository = MockIUserRepository();
    cubit = UserCubit(repository: repository);
  });

  group('Тестирование UserCubit', () {
    test('Проверка создания пользователя', () async {
      when(repository.createUser('test')).thenAnswer((_) async =>
          const UserEntity(
              id: 1, username: 'test', score: 0, isSentToServer: false));
      await cubit.createUser('test');
      expect(cubit.stateNotifier.value, isA<UserSuccessState>());
    });

    test('Проверка установки счета пользователя', () async {
      when(repository.setScores('test', 100)).thenAnswer((_) async =>
          const UserEntity(
              id: 1, username: 'test', score: 100, isSentToServer: false));
      await cubit.setScores('test', 100);
      expect(cubit.stateNotifier.value, isA<UserSuccessState>());
    });

    test('Проверка выхода из аккаунта', () async {
      cubit.signOut();
      verify(repository.deleteUserFromStorage()).called(1);
      expect(cubit.stateNotifier.value, isA<UserInitState>());
    });
  });
}
