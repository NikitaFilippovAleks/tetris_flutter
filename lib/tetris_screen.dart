import 'package:flutter/material.dart';

import 'tetris_game.dart';

class TetrisScreen extends StatelessWidget {
  final int level;
  const TetrisScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TetrisGame(level: level),
    );
  }
}
