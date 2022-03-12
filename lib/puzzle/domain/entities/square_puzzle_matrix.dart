import 'dart:developer' as developer;
import 'dart:math';
import 'dart:typed_data';
import 'package:image/image.dart' as imglib;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:puzzle_hack/puzzle/domain/entities/is_solvable.dart';

import 'point.dart';

class SquarePuzzleMatrix with ChangeNotifier {
  final int order;

  int get columnsLength => order;

  int correctlyPlacedTiles = 0;

  Future<void> shuffle() async {
    for (var i = 0; i < 10; i++) {
      _shuffle();
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 250));
    }
    totalMoves = 0;
    resetCorrectness();
    notifyListeners();
  }

  void _shuffle() {
    final random = Random();

    // https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
    for (var i = points.length - 1; i > 0; i--) {
      int n = random.nextInt(i + 1);
      swapData(points[i], points[n]);
    }
    final flatPoints = points.fold<List<int?>>(
        [],
        (prev, cur) => [
              ...prev,
              cur.isBlank ? null : int.parse(cur.data!),
            ]);
    bool _solvable = isSolvable(flatPoints, order);
    while (!_solvable) {
      developer.log('Shuffled an unsolvable puzzle adding one more inversion');

      int i = points.length - 1;
      int j = random.nextInt(points.length - 2);
      swapData(points[i], points[j]);
      final flatPoints = points.fold<List<int?>>(
          [],
          (prev, cur) => [
                ...prev,
                cur.isBlank ? null : int.parse(cur.data!),
              ]);
      _solvable = isSolvable(flatPoints, order);
    }
  }

  bool blankIsOnEvenRowFromBottom(Point point) {
    final result = (order - point.x).isEven;
    return result;
  }

  late List<Point> points;

  Point getBlankPosition() => points.firstWhere((p) => p.isBlank);

  int totalMoves = 0;

  SquarePuzzleMatrix(this.order, this.points);

  SquarePuzzleMatrix.generate(this.order) {
    final total = order * order;
    final tmpPoints = List<Point?>.generate(order * order, (index) => null);

    for (var i = 0; i < order; i++) {
      for (var j = 0; j < order; j++) {
        final index = (i * order) + j;
        final data = index == total - 1 ? null : (index + 1).toString();

        developer.log('[i][j] : [$i],[$j] ----> data:$data');
        final point = Point(
          img: null,
          x: i,
          y: j,
          data: data,
        );

        tmpPoints[index] = point;
      }
    }

    points = tmpPoints.cast<Point>();

    correctlyPlacedTiles = points.length - 1;
  }
  SquarePuzzleMatrix.generateFromImage(this.order, List<int> input) {
    final total = order * order;
    final tmpPoints = List<Point?>.generate(order * order, (index) => null);
    final imgParts = splitImage(order, input);
    for (var i = 0; i < order; i++) {
      for (var j = 0; j < order; j++) {
        final index = (i * order) + j;
        final data = index == total - 1 ? null : (index + 1).toString();

        developer.log('[i][j] : [$i],[$j] ----> data:$data');
        final point = Point(
          img: imgParts[index],
          x: i,
          y: j,
          data: data,
        );

        tmpPoints[index] = point;
      }
    }

    points = tmpPoints.cast<Point>();

    correctlyPlacedTiles = points.length - 1;
  }

  List<Image> splitImage(int order, List<int> input) {
    // convert image to image from image package

    imglib.Image image = imglib.decodeJpg(input)!;

    int x = 0, y = 0;
    int width = (image.width / order).round();
    int height = (image.height / order).round();

    // split image to parts
    List<imglib.Image> parts = <imglib.Image>[];
    for (int i = 0; i < order; i++) {
      for (int j = 0; j < order; j++) {
        parts.add(imglib.copyCrop(image, x, y, width, height));
        x += width;
      }
      x = 0;
      y += height;
    }

    // convert image from image package to Image Widget to display
    List<Image> output = <Image>[];
    for (var img in parts) {
      output.add(Image.memory(Uint8List.fromList(imglib.encodeJpg(img))));
    }

    return output;
  }

  bool onPointTap(Point point) {
    if (point.data == null) {
      return false;
    }

    if (movePoint(point, getPointBelow) ||
        movePoint(point, getPointAbove) ||
        movePoint(point, getPointToTheRight) ||
        movePoint(point, getPointToTheLeft)) {
      totalMoves++;
      notifyListeners();
      return true;
    }
    return false;
  }

  int getPointIndex(Point point) {
    return point.x * columnsLength + point.y;
  }

  bool movePoint(
    Point point,
    Point? Function(Point point) getNextPoint,
  ) {
    List<Point> pointsWalked = [];

    // get nextPoint
    Point? nextPoint = getNextPoint(point);

    // if nextPoint == null we have no room to walk
    while (nextPoint != null) {
      // if nextPoint.data == null we can start moving
      if (nextPoint.data == null) {
        // we swap data between nextPoint and point
        swapData(nextPoint, point);

        for (var i = pointsWalked.length - 1; i >= 0; i--) {
          swapData(pointsWalked[i], point);
          point = pointsWalked[i];
        }
        return true;
      }
      pointsWalked.add(point);

      point = nextPoint;
      nextPoint = getNextPoint(nextPoint);
    }
    return false;
  }

  /// Point1 and point2 will not be directly changed
  /// but data in [points] list will.
  void swapData(Point point1, Point point2) {
    final tmpData = point2.data;
    final tmpImage = point2.img;

    point2.data = point1.data;
    point2.img = point1.img;

    point1.data = tmpData;
    point1.img = tmpImage;
  }

  bool checkPointPosition(Point point) {
    if (point.isBlank) {
      return true;
    }
    final idx = getPointIndex(point);

    return idx == int.parse(point.data!) - 1;
  }

  void resetCorrectness() {
    correctlyPlacedTiles = 0;
    for (var i = 0; i < points.length; i++) {
      if (checkPointPosition(points[i])) {
        correctlyPlacedTiles++;
      }
    }
    notifyListeners();
  }

  Point? getPointAbove(Point point) {
    return points.firstWhereOrNull(
      (p) => p.x == point.x - 1 && p.y == point.y,
    );
  }

  Point? getPointBelow(Point point) {
    return points.firstWhereOrNull(
      (p) => p.x == point.x + 1 && p.y == point.y,
    );
  }

  Point? getPointToTheRight(Point point) {
    return points.firstWhereOrNull(
      (p) => p.x == point.x && p.y == point.y + 1,
    );
  }

  Point? getPointToTheLeft(Point point) {
    return points.firstWhereOrNull(
      (p) => p.x == point.x && p.y == point.y - 1,
    );
  }
}
