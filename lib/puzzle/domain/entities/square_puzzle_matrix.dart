import 'dart:developer' as developer;
import 'dart:math';
import 'package:collection/collection.dart';

import 'point.dart';

class SquarePuzzleMatrix {
  final int order;

  int get columnsLength => order;

  int numberOfInversions = 0;

  bool isSolvable() {
    if (order.isOdd) {
      return numberOfInversions.isEven;
    } else {
      final blank = getBlankPosition();
      return (blankIsOnEvenRowFromBottom(blank) && numberOfInversions.isOdd) ||
          (!blankIsOnEvenRowFromBottom(blank) && numberOfInversions.isEven);
    }
  }

  void shuffle() {
    numberOfInversions = 0;

    final random = Random();
    // https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
    for (var i = points.length - 1; i > 0; i--) {
      int n = random.nextInt(i + 1);
      swapData(points[i]!, points[n]!);
      numberOfInversions++;
      developer.log('numberOfInversions :$numberOfInversions');
    }
    
    if (!isSolvable()) {
      developer.log('Shuffled an unsolvable puzzle adding one more inversion');
      int i = points.length - 1;
      int j = random.nextInt(points.length - 2);
      swapData(points[i]!, points[j]!);
      numberOfInversions++;
      developer.log('numberOfInversions :$numberOfInversions');
    }
    
  }

  void invertPoints(int idx1, int idx2) {
    Point tmp = points[idx1]!;
    points[idx1] = points[idx2];
    points[idx2] = tmp;
  }

  bool blankIsOnEvenRowFromBottom(Point point) {
    return (order - point.x).isEven;
  }

  late List<Point?> points;

  Point getBlankPosition() => points.firstWhere((p) => p?.data == null)!;

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
          x: i,
          y: j,
          data: data,
        );

        tmpPoints[index] = point;
      }
    }
    points = tmpPoints;
  }

  bool onPointTap(Point point) {
    if (point.data == null) {
      return false;
    }

    return movePoint(point, getPointBelow) ||
        movePoint(point, getPointAbove) ||
        movePoint(point, getPointToTheRight) ||
        movePoint(point, getPointToTheLeft);
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
        //!IMPORTANT nextPoint and point data here will appear the same
        //! because data is changed in the actual points list
        for (var i = pointsWalked.length - 1; i >= 0; i--) {
          // We cant pass point here as a second argument because data is only changed in the list
          // so we grab the fresh point from points list with index
          swapData(pointsWalked[i], points[getPointIndex(point)]!);
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
    points[getPointIndex(point1)] = point1.changeData(point2.data);
    points[getPointIndex(point2)] = point2.changeData(point1.data);
    totalMoves++;
  }

  Point? getPointAbove(Point point) {
    return points.firstWhereOrNull(
      (p) => p?.x == point.x - 1 && p?.y == point.y,
    );
  }

  Point? getPointBelow(Point point) {
    return points.firstWhereOrNull(
      (p) => p?.x == point.x + 1 && p?.y == point.y,
    );
  }

  Point? getPointToTheRight(Point point) {
    return points.firstWhereOrNull(
      (p) => p?.x == point.x && p?.y == point.y + 1,
    );
  }

  Point? getPointToTheLeft(Point point) {
    return points.firstWhereOrNull(
      (p) => p?.x == point.x && p?.y == point.y - 1,
    );
  }
}
