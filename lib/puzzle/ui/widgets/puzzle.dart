import 'package:flutter/material.dart';

import 'package:puzzle_hack/puzzle/domain/entities/square_puzzle_matrix.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/puzzle_item.dart';

abstract class _SizeConstants {
  static const extraMargin = 10;
}

class Puzzle extends StatefulWidget {
  final SquarePuzzleMatrix matrix;

  const Puzzle({
    Key? key,
    required this.matrix,
  }) : super(key: key);

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  late final puzzleMatrix = widget.matrix;

  late final screenSize = MediaQuery.of(context).size;
  late final height = screenSize.height * 0.6;
  late final width = screenSize.width * 0.4;

  late final _itemHeight =
      (height / puzzleMatrix.columnsLength) - _SizeConstants.extraMargin;

  late final _itemWidth =
      (width / puzzleMatrix.columnsLength) - _SizeConstants.extraMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height + _SizeConstants.extraMargin * 2,
      width: width + _SizeConstants.extraMargin * 2,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(-6.0, -6.0),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ],
        color: const Color(0xFFEFEEEE),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: puzzleMatrix.points.map((e) {
          final data = e?.data;

          final topOffset =
              ((_itemHeight * e!.x) + (_SizeConstants.extraMargin * e.x)) +
                  _SizeConstants.extraMargin;

          final leftOffset =
              ((_itemWidth * e.y) + (_SizeConstants.extraMargin * e.y)) +
                  _SizeConstants.extraMargin;

          return AnimatedPositioned(
            curve: Curves.easeInOut,
            key: Key(
              data.toString(),
            ),
            top: topOffset,
            left: leftOffset,
            height: _itemHeight,
            width: _itemWidth,
            duration: const Duration(milliseconds: 400),
            child: PuzzleItem(
              text: e.data,
              onPointTap: data != null
                  ? () {
                      if (puzzleMatrix.onPointTap(e)) {
                        setState(() {});
                      }
                    }
                  : null,
            ),
          );
        }).toList(),
      ),
    );
  }
}
