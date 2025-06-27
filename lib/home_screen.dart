import 'package:flutter/material.dart';

import 'tetris_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TetrisScreen()));
          },
          child: const Text('Start Game'),
        ),
      ),
    );
  }
}
