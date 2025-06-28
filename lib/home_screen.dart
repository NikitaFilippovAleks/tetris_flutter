import 'package:flutter/material.dart';

import 'tetris_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _level = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Level: $_level'),
            Slider(
              min: 1,
              max: 5,
              value: _level.toDouble(),
              label: _level.toString(),
              onChanged: (double value) {
                setState(() {
                  _level = value.toInt();
                });
              },
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TetrisScreen(level: _level)));
              },
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
