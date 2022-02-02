class Point {
  final int x;
  final int y;
  String? data;

  Point copy() => Point(
        data: data,
        x: x,
        y: y,
      );

  Point({
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
