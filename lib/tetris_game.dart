import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tetris_flutter/main.dart';
import 'package:tetris_flutter/src/blocks/blocks.dart';
import 'package:tetris_flutter/src/pixel.dart';
import 'package:tetris_flutter/widgets/block_painter.dart';
import 'package:tetris_flutter/widgets/board_painter.dart';

import '/src/board.dart';
import '/src/game.dart';
import 'game_over_modal.dart';
import 'tetris_header.dart';

class TetrisGame extends StatefulWidget {
  final int level;
  final Set<Block> activeBlocks;
  const TetrisGame({super.key, required this.level, required this.activeBlocks});

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
      activeBlocks: widget.activeBlocks,
      onGameOver: (scores) {
        // Переход на экран окончания игры
        // Передаем scores в аргументах
        Navigator.pushReplacementNamed(
          context,
          GameRouter.gameOverRoute,
          arguments: {'scores': scores},
        );
      },
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
                      return BlockPainter(game.nextBlock, size);
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
                      painter: BoardPainter(board, blockSize),
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
