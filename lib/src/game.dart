import 'dart:async';
import 'dart:ui';

import 'blocks/blocks.dart';
import 'board.dart';

final class Game {
  late Board board;
  late Block currentBlock; // текущий блок
  late Block nextBlock; // следующий блок
  bool _isGameOver = false;
  bool _isPaused = false;
  int score = 0;
  int level = 1;
  VoidCallback onUpdate;

  // Обратный вызов при окончании игры
  final Function(String scores) onGameOver;

  Game({required this.onGameOver, required this.onUpdate}) {
    requestDifficultyLevel();
    keyboardEventHandler();
    initBoard();
  }

  // Метод запуска игры
  Future<void> start() async {
    // Запускаем игровой цикл
    while (!_isGameOver) {
      nextStep();
      await Future.delayed(const Duration(milliseconds: 500));
      onUpdate(); // Вызывается на каждый цикл игры
    }
    onGameOver(score.toString());// Вызывается при завершении игры
  }

  // // Метод запуска игры
  // Future<void> start() async {
  //   // Запускаем игровой цикл
  //   while (!isGameOver) {
  //     if (!_isPaused) {
  //       nextStep();
  //       printScore();
  //       await Future.delayed(Duration(milliseconds: (500 / level).round()));
  //     } else {
  //       await Future.delayed(const Duration(milliseconds: 500));
  //     }
  //   }

  //   // ....
  // }

  void initBoard() {
    currentBlock = getNewRandomBlock();
    nextBlock = getNewRandomBlock();

    board = Board(
        currentBlock: currentBlock,
        newBlockFunc: newBlock,
        updateScore: updateScore,
        updateBlock: updateBlock,
        gameOver: gameOver,
        resetGame: restart,
        pauseGame: pauseGame);
  }

  // Метод обновления блока фигуры
  void updateBlock(Block block) {
    currentBlock = block;
  }

  // Метод обновления счета
  void updateScore() {
    score += 10;

    // увеличение уровня
    int newLevel = score ~/ 20;
    level = newLevel == 0 ? 1 : newLevel;
  }

  // Метод генерации новой фигуры
  (Block, Block) newBlock() {
    currentBlock = nextBlock;
    nextBlock = getNewRandomBlock();
    return (currentBlock, nextBlock);
  }

  // Метод для установки прослушивания нажатий клавиш
  // и передачи ASCII-кода нажатой клавиши на уровень ниже
  void keyboardEventHandler() {
    // ....
  }

  // Метод вывода текущего счета в игре
  void printScore() {
    // ....
  }

  bool get isGameOver => _isGameOver;

  void gameOver() {
    _isGameOver = true;
  }

  void restart() {
    if (isGameOver) {
      // ....
      _isGameOver = false;
      score = 0;
      initBoard();
      start();
    }
  }

  void pauseGame() {
    if (!_isGameOver) {
      _isPaused = !_isPaused;

      if (_isPaused) {
        // ....
      } else {
        // ....
      }
    }
  }

  // Метод обработки шага игрового цикла
  void nextStep() {
    var x = currentBlock.x;
    var y = currentBlock.y;

    if (!board.isFilledBlock(x, y + 1)) {
      board.moveBlock(x, y + 1);
    } else {
      board.clearLine();
      board.savePresentBoardToCpy();
      board.newBlock();
      board.drawBoard();
    }
  }

  // Метод для запроса уровня сложности у пользователя
  void requestDifficultyLevel() {
    // ....
  }
}
