import 'package:flutter/material.dart';
import 'package:tetris_flutter/app/context_ext.dart';
import 'package:tetris_flutter/app/game_router.dart';
import 'package:tetris_flutter/features/game/game_scores.dart';
import 'package:tetris_flutter/features/user/domain/state/user_state.dart';

///  Экран окончания игры
class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
      builder: (context, state, child) {
        return switch (state) {
          UserLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
          UserSuccessState() => GameScores(
              score: state.userEntity.score,
              onRestart: () {
                // Переход на экран игры
                Navigator.pushReplacementNamed(
                  context,
                  GameRouter.gameRoute,
                );
              }),
          _ => const SizedBox.shrink(),
        };
      },
      valueListenable: context.di.userCubit.stateNotifier,
    ));
  }
}
