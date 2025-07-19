import 'package:flutter/material.dart';

enum PixelType {
  free,
  filled,
  border,
}

class Pixel {
  final PixelType type;
  final Color color;

  Pixel({required this.type, required this.color});

  Pixel operator +(Pixel other) {
    if (type == PixelType.border || other.type == PixelType.border) {
      return BorderPixel();
    }

    if (type == PixelType.filled && other.type == PixelType.filled) {
      return BorderPixel();
    }

    if (type == PixelType.free && other.type == PixelType.free) {
      return FreePixel();
    }

    if (type == PixelType.filled && other.type == PixelType.free) {
      return this;
    }

    if (type == PixelType.free && other.type == PixelType.filled) {
      return other;
    }

    return other;
  }

  Pixel operator -(Pixel other) {
    if (type == PixelType.border || other.type == PixelType.border) {
      return BorderPixel();
    }

    if (type == PixelType.filled && other.type == PixelType.filled) {
      return FreePixel();
    }

    if (type == PixelType.free && other.type == PixelType.free) {
      return FreePixel();
    }

    if (type == PixelType.filled && other.type == PixelType.free) {
      return this;
    }

    if (type == PixelType.free && other.type == PixelType.filled) {
      return other;
    }

    return FreePixel();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pixel && type == other.type;
  }

  @override
  int get hashCode => type.hashCode;
}

class FreePixel extends Pixel {
  FreePixel() : super(type: PixelType.free, color: Colors.black);
}

class BorderPixel extends Pixel {
  BorderPixel() : super(type: PixelType.border, color: Colors.red);
}
