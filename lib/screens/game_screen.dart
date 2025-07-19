import 'package:flutter/material.dart';

import '../tetris_game.dart';

class GameScreen extends StatelessWidget {
  // final int level;
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final level = int.tryParse(args.toString()) ?? 0;

    return Scaffold(
      body: TetrisGame(level: level),
    );
  }
}
