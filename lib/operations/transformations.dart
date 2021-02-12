import 'dart:math';

/// Adds Geometric Transformations to Point
extension Transformations on Point {
  /// Moves the point by the amount wanted, creating a new point.
  Point translate(num moveX, num moveY) {
    return Point(x + moveX, y + moveY);
  }

  /// Rotates the point, creating a new point.
  Point rotate(num angle) {
    final rads = angle * pi / 180;
    return Point(
        (x * cos(rads) + y * sin(rads)), (y * cos(rads) - x * sin(rads)));
  }

  /// Moves the point based in resizing.
  Point resize(num scaleX, scaleY) {
    return Point(x * scaleX, y * scaleY);
  }
}
