import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_hack/puzzle/domain/entities/point.dart';

import 'package:puzzle_hack/puzzle/domain/entities/square_puzzle_matrix.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/puzzle_item_bubble.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/whirlwind.dart';

import '../pages/bloc/puzzle_screen_bloc.dart';

class Puzzle extends StatefulWidget {
  final SquarePuzzleMatrix matrix;
  final double itemWidth;
  final double itemHeight;
  final void Function(Point) onPointTap;

  const Puzzle({
    Key? key,
    required this.onPointTap,
    required this.matrix,
    required this.itemWidth,
    required this.itemHeight,
  }) : super(key: key);

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzleScreenBloc, PuzzleScreenState>(
      builder: (context, state) {
        return Stack(
          children: widget.matrix.points.map(
            (e) {
              final data = e.data;
              return AnimatedAlign(
                curve: Curves.easeInOut,
                key: Key(
                  data.toString(),
                ),
                alignment: FractionalOffset(
                  state.isShuffling ? -1 : ((e.y) / (widget.matrix.order - 1)),
                  state.isShuffling ? 1.5 : (e.x) / (widget.matrix.order - 1),
                ),
                duration: state.isPlaying ? const Duration(milliseconds: 400) : const Duration(seconds: 1),
                child: SizedBox(
                  height: widget.itemHeight,
                  width: widget.itemWidth,
                  child: PuzzleItemBubble(
                    p: e,
                    onPointTap: data != null
                        ? () {
                            widget.onPointTap(e);
                          }
                        : null,
                  ),
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
