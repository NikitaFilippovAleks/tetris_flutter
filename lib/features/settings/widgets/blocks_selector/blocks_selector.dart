import 'package:flutter/material.dart';
import 'package:tetris_flutter/models/settings_model.dart';
import 'package:tetris_flutter/features/game/src/blocks/blocks.dart';
import 'package:tetris_flutter/shared/block_painter.dart';

part 'block_item.dart';

class BlocksSelector extends StatelessWidget {
  const BlocksSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsModel = SettingsProvider.of(context);
    return Column(
      spacing: 20,
      children: [
        Text('Blocks selector', style: Theme.of(context).textTheme.titleLarge),
        GridView.count(
          shrinkWrap: true,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          children: allBlocksTypes.toList().map((e) {
            final isActive = settingsModel.activeBlocks.contains(e);
            return BlockItem(
                isActive: isActive,
                onTap: (block) {
                  if (isActive) {
                    if (settingsModel.activeBlocks.length <= 3) {
                      return;
                    }
                    settingsModel.removeActiveBlock(block);
                  } else {
                    settingsModel.addActiveBlock(block);
                  }
                },
                blockData: e,
                size: Size.square(
                  MediaQuery.of(context).size.width / 5,
                ));
          }).toList(),
        ),
      ],
    );
  }
}
