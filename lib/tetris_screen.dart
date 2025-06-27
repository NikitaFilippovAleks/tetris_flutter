import 'package:flutter/material.dart';

import 'tetris_game.dart';

class TetrisScreen extends StatelessWidget {
  const TetrisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TetrisGame(),
    );
  }
}
