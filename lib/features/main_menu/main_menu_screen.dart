import 'package:flutter/material.dart';
import 'package:tetris_flutter/app/game_router.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            FilledButton(
              onPressed: () {
                Navigator.pushNamed(context, GameRouter.userRoute);
              },
              child: const Text('Start Game'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pushNamed(context, GameRouter.settingsRoute);
              },
              child: const Text('Settings'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pushNamed(context, GameRouter.leaderboardRoute);
              },
              child: const Text('Leaderboard'),
            ),
          ],
        ),
      ),
    );
  }
}
