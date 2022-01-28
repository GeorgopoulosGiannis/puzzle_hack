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
  late final screenSize = MediaQuery.of(context).size;
  late final height = screenSize.height * 0.6;
  late final width = screenSize.width * 0.4;

  late final _itemHeight =
      (height / puzzleMatrix.columnsLength) - _SizeConstants.extraMargin;
  late final puzzleMatrix = widget.matrix;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: height,
        maxWidth: width,
      ),
      child: Stack(
        children: puzzleMatrix.points.map((e) {
          final data = e?.data;

          return AnimatedPositioned(
            curve: Curves.easeInOut,
            key: Key(data.toString()),
            top: (_itemHeight * e!.x) + (_SizeConstants.extraMargin * e.x),
            left: (_itemHeight * e.y) + (_SizeConstants.extraMargin * e.y),
            height: _itemHeight,
            width: _itemHeight,
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
