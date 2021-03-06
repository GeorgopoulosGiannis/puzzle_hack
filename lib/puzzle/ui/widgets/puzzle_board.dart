import 'package:flutter/material.dart';
import 'package:puzzle_hack/core/widgets/responsive_layout_builder.dart';
import 'package:puzzle_hack/puzzle/domain/entities/square_puzzle_matrix.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/puzzle.dart';

abstract class _SizeConstants {
  static const extraMargin = 10;
}

class PuzzleBoard extends StatefulWidget {
  final SquarePuzzleMatrix matrix;
  const PuzzleBoard({
    Key? key,
    required this.matrix,
  }) : super(key: key);

  @override
  State<PuzzleBoard> createState() => _PuzzleBoardState();
}

class _PuzzleBoardState extends State<PuzzleBoard> {
  late final screenSize = MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (context, child) {
        late final height = screenSize.height * 0.5;
        late final width = screenSize.width * 0.8;
        late final _itemHeight = (height / widget.matrix.order) - _SizeConstants.extraMargin;

        late final _itemWidth = (width / widget.matrix.order) - _SizeConstants.extraMargin;
        return SizedBox(
          height: height + _SizeConstants.extraMargin,
          width: width + _SizeConstants.extraMargin,
          child: Puzzle(
            matrix: widget.matrix,
            itemWidth: _itemWidth,
            itemHeight: _itemHeight,
          ),
        );
      },
      medium: (context, child) {
        late final height = screenSize.height * 0.9;
        late final width = screenSize.width * 0.55;
        late final _itemHeight = (height / widget.matrix.order);

        late final _itemWidth = (width / widget.matrix.order);
        return SizedBox(
          height: height,
          width: width,
          child: Puzzle(
            matrix: widget.matrix,
            itemWidth: _itemWidth,
            itemHeight: _itemHeight,
          ),
        );
      },
      large: (context, child) {
        late final height = screenSize.height * 0.6;
        late final width = screenSize.width * 0.4;
        late final _itemHeight = (height / widget.matrix.order) - _SizeConstants.extraMargin;

        late final _itemWidth = (width / widget.matrix.order) - _SizeConstants.extraMargin;
        return SizedBox(
          height: height + _SizeConstants.extraMargin * 2,
          width: width + _SizeConstants.extraMargin * 2,
          child: Puzzle(
            matrix: widget.matrix,
            itemWidth: _itemWidth,
            itemHeight: _itemHeight,
          ),
        );
      },
    );
  }
}
