import 'package:tetris_flutter/features/game/src/pixel.dart';

import 'blocks/blocks.dart';

class Board {
  static const int heightBoard = 20;
  static const int widthBoard = 10;
  static Pixel posFree = FreePixel();
  // static Pixel posFilled = Pixel(type: PixelType.filled, color: Colors.white);
  static Pixel posBoarder = BorderPixel();

  late List<List<Pixel>> mainBoard;
  late List<List<Pixel>> mainCpy;

  // callback-функция для создания нового блока
  (Block, Block) Function() newBlockFunc;

  // callback-функция для обновления счета
  void Function() updateScore;

  // callback-функция для обновления блока
  void Function(Block block) updateBlock;

  // callback-функция завершения игры
  void Function() gameOver;

  void Function() resetGame;

  void Function() pauseGame;

  Block currentBlock; // текущий блок с игровой фигурой

  Board({
    required this.newBlockFunc,
    required this.currentBlock,
    required this.updateScore,
    required this.updateBlock,
    required this.gameOver,
    required this.resetGame,
    required this.pauseGame,
  }) {
    mainBoard = List.generate(
      heightBoard,
      (_) => List.filled(widthBoard, posFree),
    );
    mainCpy = List.generate(
      heightBoard,
      (_) => List.filled(widthBoard, posFree),
    );
    initDrawMain();
  }

  // обработка нажатия клавиш по их ASCII-коду
  void keyboardEventHandler(int key) {
    var x = currentBlock.x;
    var y = currentBlock.y;

    print('key: $key');

    switch (key) {
      case 119: // W – поворот фигуры
        rotateBlock();
      case 97: // A - влево
        if (!isFilledBlock(x - 1, y)) {
          moveBlock(x - 1, y);
        }
      case 115: // S - вниз
        if (!isFilledBlock(x, y + 1)) {
          moveBlock(x, y + 1);
        }
      case 100: // D - вправо
        if (!isFilledBlock(x + 1, y)) {
          moveBlock(x + 1, y);
        }
      case 4294967323: // ESC - выход из игры
        gameOver();
      case 114: // R - рестарт игры
        resetGame();
      case 32: // Space - пауза
        pauseGame();
    }

    updateBlock(currentBlock);
  }

  // сохранение текущего состояния игрового поля
  void savePresentBoardToCpy() {
    for (int i = 0; i < heightBoard - 1; i++) {
      for (int j = 0; j < widthBoard - 1; j++) {
        mainCpy[i][j] = mainBoard[i][j];
      }
    }
  }

  // Метод инициализации игровой доски
  void initDrawMain() {
    for (int i = 0; i <= heightBoard - 1; i++) {
      for (int j = 0; j <= widthBoard - 1; j++) {
        if (j == 0 || j == widthBoard - 1 || i == heightBoard - 1) {
          mainBoard[i][j] = posBoarder;
          mainCpy[i][j] = posBoarder;
        }
      }
    }

    newBlock();
    drawBoard();
  }

  // Метод отрисовки основной доски
  void drawBoard() {
    //....
  }

  void drawNextBlockHint(Block nextBlock) {
    //....
  }

  // Метод генерации нового блока и добавления его на основную доску
  void newBlock() {
    final (currentBlockNew, nextBlock) = newBlockFunc();
    currentBlock = currentBlockNew;
    var x = currentBlock.x;

    // добавляем новый блок на основную доску
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (x + j >= 0 && x + j < widthBoard && i < heightBoard) {
          mainBoard[i][x + j] = mainCpy[i][x + j] + currentBlock[i][j];

          // проверка на пересечение
          if (mainBoard[i][x + j].type == PixelType.border) {
            gameOver(); // игра окончена
          }
        }
      }
    }

    drawNextBlockHint(nextBlock);
  }

  bool isInBoard(int x, int y, int j, int i) {
    return x + j >= 0 &&
        x + j < widthBoard &&
        y + i >= 0 &&
        y + i < heightBoard;
  }

  // Метод перемещения фигуры по основной доске
  void moveBlock(int x2, int y2) {
    // убираем фигуру с текущей позиции
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (isInBoard(currentBlock.x, currentBlock.y, j, i)) {
          mainBoard[currentBlock.y + i][currentBlock.x + j] -=
              currentBlock[i][j];
        }
      }
    }

    // устанавливаем новую позицию
    currentBlock.move(x2, y2);

    // добавляем фигуру на новую позицию
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        // проверка на левый край, правый край и нижний край
        if (isInBoard(currentBlock.x, currentBlock.y, j, i)) {
          mainBoard[currentBlock.y + i][currentBlock.x + j] +=
              currentBlock[i][j];
        }
      }
    }

    drawBoard();
  }

  // Метод обработки поворота блока
  void rotateBlock() {
    // Временный блок с текущей фигурой
    var tmpBlock = currentBlock.copyWith();
    currentBlock.rotate(); // Поворачиваем фигуру

    // Проверка на то, что фигура не пересекается с границей
    // или другими блоками ранее помещенных на доску фигур
    if (isFilledBlock(tmpBlock.x, tmpBlock.y)) {
      currentBlock = tmpBlock;
      // обновляем текущую фигуру в классе Game
      updateBlock(currentBlock);
    }

    var x = currentBlock.x;
    var y = currentBlock.y;

    // Обновляем основную доску
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (isInBoard(x, y, j, i)) {
          // убираем старую фигуру
          mainBoard[y + i][x + j] -= tmpBlock[i][j];

          // добавляем новую фигуру
          mainBoard[y + i][x + j] += currentBlock[i][j];
        }
      }
    }

    drawBoard();
  }

  // Метод очистки заполненных строк
  void clearLine() {
    for (int j = 0; j <= heightBoard - 2; j++) {
      // проверка заполненности строки
      int i = 1;
      while (i <= widthBoard - 2) {
        if (mainBoard[j][i] == posFree) {
          break;
        }
        i++;
      }

      if (i == widthBoard - 1) {
        // если строка заполнена
        // очистка строки и сдвиг строк игровой доски вниз
        for (int k = j; k > 0; k--) {
          for (int idx = 1; idx <= widthBoard - 1; idx++) {
            mainBoard[k][idx] = mainBoard[k - 1][idx];
          }
        }
        // вызываем callBack-функцию для увеличение очков
        updateScore();
      }
    }
  }

  // Метод проверки возможности сдвига блока в заданном направлении
  bool isFilledBlock(int x2, int y2) {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (isInBoard(x2, y2, j, i)) {
          if (currentBlock[i][j] != FreePixel() &&
              mainCpy[y2 + i][x2 + j] != FreePixel()) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
