import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/src/board.dart';
import '/src/game.dart';
import 'game_over_modal.dart';
import 'tetris_header.dart';

// Класс отрисовки игрового поля
class _GamePainter extends CustomPainter {
  // Игровое поле
  final List<List<int>> board;
  // Размер блока
  final double blockSize;

  _GamePainter(this.board, this.blockSize);

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
        switch (board[i][j]) {
          // Отрисовка пустых клеток поля
          case Board.posFree:
            paint.color = Colors.black;
          // Отрисовка блоков и заполненных клеток поля
          case Board.posFilled:
            paint.color = Colors.white;
          // Отрисовка границ поля
          case Board.posBoarder:
            paint.color = Colors.red;
        }
        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class TetrisGame extends StatefulWidget {
  final int level;
  const TetrisGame({super.key, required this.level});

  @override
  State<TetrisGame> createState() => _TetrisGameState();
}

class _TetrisGameState extends State<TetrisGame> {
  late Game game;

  // Метод для отображения диалогового окна при завершении игры
  // Принимает параметр scores в виде строки, содержащий набранные очки
  void _showGameOverDialog(String scores) {
    // Проверяем, что виджет все еще находится в дереве виджетов
    // Если виджет удален, прерываем выполнение метода
    if (!mounted) return;

    // Планируем показ диалога на следующий кадр отрисовки.
    // Это гарантирует, что диалог появится после полной
    // инициализации виджета
    // WidgetsBinding.instance.addPostFrameCallback((_) {
      // Показываем диалоговое окно
      showDialog(
        // Передаем контекст для правильного позиционирования диалога
        context: context,
        // Запрещаем закрытие диалога при клике вне его области
        barrierDismissible: false,
        // Функция построения содержимого диалога
        builder: (BuildContext context) {
          // Возвращаем виджет AlertDialog с информацией
          // об окончании игры
          return GameOverModal(
              scores: scores,
              onPlayAgain: () {
                game.restart();
              },
              onExit: () {
                Navigator.of(context).pop();
              });
        },
      );
    // });
  }

  @override
  void initState() {
    super.initState();
    game = Game(
      level: widget.level,
      onGameOver: _showGameOverDialog,
    );
    game.start();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: game,
      builder: (_, __) => Focus(
        autofocus: true,
        onKeyEvent: (FocusNode node, KeyEvent event) {
          // Обработка нажатий клавиш
          // Обрабатываем как нажатие, так и удержание клавиши
          if (event is KeyDownEvent || event is KeyRepeatEvent) {
            game.board.keyboardEventHandler(event.logicalKey.keyId);
            return KeyEventResult.handled;
          }
          // Если событие не обработано, возвращаем ignored
          return KeyEventResult.ignored;
        },
        child: Align(
          alignment: Alignment.center,
          // Получаем размеры виджета
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TetrisHeader(
                    score: game.score,
                    level: game.activeLevel,
                    nextBlockRenderer: (size) {
                      double blockSize = size.width / 4;
                      return CustomPaint(
                        painter:
                            _GamePainter(game.nextBlock.blockData, blockSize),
                        size: size,
                      );
                    }),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final board = game.board.mainBoard;
                    // Вычисляем размер клетки поля
                    double blockSize = min(
                      constraints.maxWidth / board[0].length,
                      constraints.maxHeight / board.length,
                    );
      
                    return CustomPaint(
                      painter: _GamePainter(board, blockSize),
                      size: Size(
                        board[0].length * blockSize,
                        board.length * blockSize,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
