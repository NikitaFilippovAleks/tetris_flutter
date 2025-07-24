import 'package:flutter/material.dart';

// Виджет для отображения количества набранных очков
// и кнопки для перезапуска игры после завершения игры
class GameScores extends StatelessWidget {
  final int score;
  final Function() onRestart;
  const GameScores({super.key, required this.score, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Text('Заработанные очки: $score',
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          FilledButton(
            onPressed: onRestart,
            child: const Text('Перезапустить игру'),
          ),
        ],
      ),
    );
  }
}
