import 'package:flutter/material.dart';

class GameOverModal extends StatelessWidget {
  final String scores;
  final Function() onPlayAgain;
  final Function() onExit;

  const GameOverModal(
      {super.key,
      required this.scores,
      required this.onPlayAgain,
      required this.onExit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Заголовок диалога
      title: const Text('Game Over'),
      // Текст с количеством набранных очков
      content: Text('Your score: $scores'),
      // Список кнопок действий (пока пустой)
      actions: [
        FilledButton(
            onPressed: () {
              onPlayAgain();
              Navigator.of(context).pop();
            },
            child: const Text('Play Again')),
        FilledButton(
            onPressed: () {
              onExit();
              Navigator.of(context).pop();
            },
            child: const Text('Exit')),
      ],
    );
  }
}
