import 'package:flutter/widgets.dart';

class Point {
  final int x;
  final int y;
  String? data;
  Image? img;

  Point({
    required this.img,
    required this.x,
    required this.y,
    required this.data,
  });

  bool get isBlank => data == null;

  @override
  String toString() {
    return 'Point at [$x,$y] with data : $data';
  }
}
