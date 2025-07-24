import 'package:flutter/material.dart';
import 'package:tetris_flutter/features/game/src/pixel.dart';

// Класс отрисовки игрового поля
class BoardPainter extends CustomPainter {
  // Игровое поле
  final List<List<Pixel>> board;
  // Размер блока
  final double blockSize;

  BoardPainter(this.board, this.blockSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        Rect rect = Rect.fromLTWH(
          j * blockSize,
          i * blockSize,
          blockSize,
          blockSize,
        );
        paint.color = board[i][j].color;
        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
