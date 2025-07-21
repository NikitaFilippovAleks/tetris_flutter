import 'package:flutter/material.dart';

class LevelSelector extends StatelessWidget {
  final int level;
  final Function(int) onLevelChanged;
  const LevelSelector({super.key, required this.level, required this.onLevelChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Level: $level'),
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
