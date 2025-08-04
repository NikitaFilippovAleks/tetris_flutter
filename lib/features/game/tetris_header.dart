import 'package:flutter/material.dart';
import 'package:tetris_flutter/app/utils.dart';
import 'package:tetris_flutter/l10n/gen/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(bottom: BorderSide(color: Colors.red, width: 2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Text(
                      '${l10n.score}: $score',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${l10n.level}: $level',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${l10n.username}: ${Utils.getUsername(context)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
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
