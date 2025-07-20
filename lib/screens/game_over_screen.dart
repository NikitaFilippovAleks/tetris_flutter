import 'package:flutter/material.dart';
import 'package:tetris_flutter/main.dart';
import 'package:tetris_flutter/widgets/game_scores.dart';

///  Экран окончания игры
class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем заработанные очки, переданные в маршрут
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final scores = int.tryParse(args?['scores']?.toString() ?? '0') ?? 0;

    return Scaffold(
        body: GameScores(
            score: scores,
            onRestart: () {
              // Переход на экран игры
              Navigator.pushReplacementNamed(
                context,
                GameRouter.gameRoute,
              );
            }));
  }
}
