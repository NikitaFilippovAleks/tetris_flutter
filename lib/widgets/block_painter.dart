import 'package:flutter/material.dart';
import 'package:tetris_flutter/src/blocks/block.dart';
import 'package:tetris_flutter/widgets/board_painter.dart';

class BlockPainter extends StatelessWidget {
  final Block blockData;
  final Size blockSize;

  const BlockPainter(this.blockData, this.blockSize, {super.key});

  @override
  Widget build(BuildContext context) {
    double blockSizeAdaptive = blockSize.width / 4;

    return CustomPaint(
      painter: BoardPainter(blockData.blockData, blockSizeAdaptive),
      size: blockSize,
    );
  }
}
