class Point {
  final int x;
  final int y;
  final String? data;

  Point({
    required this.x,
    required this.y,
    required this.data,
  });

  Point changeData(String? newData) => Point(
        x: x,
        y: y,
        data: newData,
      );

  bool get isBlank => data == null;

  @override
  String toString() {
    return 'Point at [$x,$y] with data : $data';
  }
}
