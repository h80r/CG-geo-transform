import 'dart:math';

extension on num {
  double toDoubleAsFixed(int fractionDigits) {
    return double.parse(toStringAsFixed(fractionDigits));
  }
}

/// Adds Geometric Transformations to Point
extension Transformations on Point {
  /// Moves the point by the amount wanted, creating a new point.
  Point _translate(num moveX, num moveY) {
    return Point(x + moveX, y + moveY);
  }

  /// Translate interface
  Point translate(List<num> input) {
    return _translate(input[0], input[1]);
  }

  /// Rotates the point, creating a new point.
  Point _rotate(num angle) {
    final rads = angle * pi / 180;
    final newX = x * cos(rads) + y * sin(rads);
    final newY = y * cos(rads) - x * sin(rads);
    return Point(newX.toDoubleAsFixed(3), newY.toDoubleAsFixed(3));
  }

  /// Rotate interface
  Point rotate(List<num> input) {
    return _rotate(input[0]);
  }

  /// Moves the point based in resizing.
  Point _resize(num scaleX, scaleY) {
    return Point(x * scaleX, y * scaleY);
  }

  /// Resize interface
  Point resize(List<num> input) {
    return _resize(input[0], input[1]);
  }
}
