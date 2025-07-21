import 'package:flutter/material.dart';

class TetrisHeader extends StatelessWidget {
  final int score;
  final int level;
  final Widget Function(Size size) nextBlockRenderer;

  const TetrisHeader(
      {super.key,
      required this.score,
      required this.level,
      required this.nextBlockRenderer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(bottom: BorderSide(color: Colors.red, width: 2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 10,
          children: [
            Text(
              'Score: $score',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Level: $level',
              style: const TextStyle(color: Colors.white),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: nextBlockRenderer(const Size(40, 40)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
