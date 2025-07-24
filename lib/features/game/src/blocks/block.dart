// Базовый класс блока, хранящего в себе игровую фигуру
import 'package:tetris_flutter/features/game/src/pixel.dart';

base class Block {
  int _x;
  int _y;

  List<List<Pixel>> _block =
      List.generate(4, (index) => List.filled(4, FreePixel()));

  Block({
    required List<List<Pixel>> block,
    int x = 4,
    int y = 0,
  })  : _block = block,
        _x = x,
        _y = y;

  int get x => _x;
  int get y => _y;

  // Getter для доступа к данным блока для отрисовки
  List<List<Pixel>> get blockData => _block;

  // Метод перемещения фигуры
  void move(int x, int y) {
    _x = x;
    _y = y;
  }

  // Метод параметризированного копирования фигуры
  Block copyWith({int? xParam, int? yParam}) {
    List<List<Pixel>> tmp =
        List.generate(4, (_) => List.filled(4, FreePixel()));
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        tmp[i][j] = _block[i][j];
      }
    }
    return Block(
      block: tmp,
      x: xParam ?? _x,
      y: yParam ?? _y,
    );
  }

  // Метод поворота
  void rotate() {
    List<List<Pixel>> tmp =
        List.generate(4, (_) => List.filled(4, FreePixel()));
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        tmp[i][j] = _block[j][3 - i];
      }
    }
    _block = tmp;
  }

  // Оператор индексирования
  List<Pixel> operator [](int index) {
    return _block[index];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Block) return false;

    // Сравниваем по типу класса
    return runtimeType == other.runtimeType;
  }

  @override
  int get hashCode {
    // Хеш на основе типа класса
    return runtimeType.hashCode;
  }
}
