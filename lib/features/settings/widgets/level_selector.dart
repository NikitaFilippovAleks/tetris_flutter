import 'package:flutter/material.dart';
import 'package:tetris_flutter/l10n/gen/app_localizations.dart';

class LevelSelector extends StatelessWidget {
  final int level;
  final Function(int) onLevelChanged;
  const LevelSelector(
      {super.key, required this.level, required this.onLevelChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        Text('${l10n.level}: $level'),
        Slider(
          min: 1,
          max: 5,
          value: level.toDouble(),
          label: level.toString(),
          onChanged: (double value) {
            onLevelChanged(value.toInt());
          },
        ),
      ],
    );
  }
}
