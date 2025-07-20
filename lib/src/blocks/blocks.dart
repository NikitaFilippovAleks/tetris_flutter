import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_flutter/src/pixel.dart';

import 'block.dart';

export 'block.dart';

final iBlockPixel = Pixel(type: PixelType.filled, color: Colors.blue);

final class IBlock extends Block {
  IBlock()
      : super(
          block: [
            [0, 0, 0, 0],
            [1, 1, 1, 1],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
          ]
              .map((e) =>
                  e.map((e) => e == 1 ? iBlockPixel : FreePixel()).toList())
              .toList(),
        );
}

final oBlockPixel = Pixel(type: PixelType.filled, color: Colors.yellow);

final class OBlock extends Block {
  OBlock()
      : super(
          block: [
            [0, 0, 0, 0],
            [0, 1, 1, 0],
            [0, 1, 1, 0],
            [0, 0, 0, 0],
          ]
              .map((e) =>
                  e.map((e) => e == 1 ? oBlockPixel : FreePixel()).toList())
              .toList(),
        );
}

final tBlockPixel = Pixel(type: PixelType.filled, color: Colors.purple);

final class TBlock extends Block {
  TBlock()
      : super(
          block: [
            [0, 0, 0, 0],
            [1, 1, 1, 0],
            [0, 1, 0, 0],
            [0, 0, 0, 0],
          ]
              .map((e) =>
                  e.map((e) => e == 1 ? tBlockPixel : FreePixel()).toList())
              .toList(),
        );
}

final lBlockPixel = Pixel(type: PixelType.filled, color: Colors.orange);

final class LBlock extends Block {
  LBlock()
      : super(
          block: [
            [0, 0, 0, 0],
            [1, 1, 1, 0],
            [1, 0, 0, 0],
            [0, 0, 0, 0],
          ]
              .map((e) =>
                  e.map((e) => e == 1 ? lBlockPixel : FreePixel()).toList())
              .toList(),
        );
}

final jBlockPixel = Pixel(type: PixelType.filled, color: Colors.green);

final class JBlock extends Block {
  JBlock()
      : super(
          block: [
            [0, 0, 0, 0],
            [1, 1, 1, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 0],
          ]
              .map((e) =>
                  e.map((e) => e == 1 ? jBlockPixel : FreePixel()).toList())
              .toList(),
        );
}

final sBlockPixel = Pixel(type: PixelType.filled, color: Colors.pinkAccent);

final class SBlock extends Block {
  SBlock()
      : super(
          block: [
            [0, 0, 0, 0],
            [0, 1, 1, 0],
            [1, 1, 0, 0],
            [0, 0, 0, 0],
          ]
              .map((e) =>
                  e.map((e) => e == 1 ? sBlockPixel : FreePixel()).toList())
              .toList(),
        );
}

final zBlockPixel = Pixel(type: PixelType.filled, color: Colors.indigoAccent);

final class ZBlock extends Block {
  ZBlock()
      : super(
          block: [
            [0, 0, 0, 0],
            [1, 1, 0, 0],
            [0, 1, 1, 0],
            [0, 0, 0, 0],
          ]
              .map((e) =>
                  e.map((e) => e == 1 ? zBlockPixel : FreePixel()).toList())
              .toList(),
        );
}

final arcBlockPixel = Pixel(type: PixelType.filled, color: Colors.lime);

final class ArcBlock extends Block {
  ArcBlock()
      : super(
          block: [
            [0, 0, 0, 0],
            [1, 1, 1, 0],
            [1, 0, 1, 0],
            [0, 0, 0, 0],
          ]
              .map((e) =>
                  e.map((e) => e == 1 ? arcBlockPixel : FreePixel()).toList())
              .toList(),
        );
}

Block getNewRandomBlock(Set<Block> activeBlocks) {
  print('activeBlocks: $activeBlocks');
  final availableBlocks =
      _defBlocks.where((e) => activeBlocks.contains(e)).toList();
  print('availableBlocks: $availableBlocks');
  return availableBlocks[Random().nextInt(availableBlocks.length)].copyWith();
}

final _defBlocks = [
  OBlock(),
  IBlock(),
  IBlock()..rotate(),
  LBlock(),
  LBlock()..rotate(),
  JBlock(),
  JBlock()..rotate(),
  TBlock(),
  TBlock()..rotate(),
  TBlock()
    ..rotate()
    ..rotate(),
  TBlock()
    ..rotate()
    ..rotate()
    ..rotate(),
  SBlock(),
  SBlock()..rotate(),
  SBlock()
    ..rotate()
    ..rotate(),
  SBlock()
    ..rotate()
    ..rotate()
    ..rotate(),
  ZBlock(),
  ZBlock()..rotate(),
  ZBlock()
    ..rotate()
    ..rotate(),
  ZBlock()
    ..rotate()
    ..rotate()
    ..rotate(),
  ArcBlock(),
  ArcBlock()..rotate(),
  ArcBlock()
    ..rotate()
    ..rotate(),
  ArcBlock()
    ..rotate()
    ..rotate()
    ..rotate(),
];

Set<Block> allBlocksTypes = {
  IBlock(),
  OBlock(),
  TBlock(),
  LBlock(),
  JBlock(),
  SBlock(),
  ZBlock(),
  ArcBlock()
};
