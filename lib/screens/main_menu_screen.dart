import 'package:flutter/material.dart';
import 'package:tetris_flutter/main.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainMenuScreen> {
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
                Navigator.pushNamed(context, GameRouter.gameRoute,
                    arguments: _level);
              },
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
