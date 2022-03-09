import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_hack/puzzle/domain/entities/point.dart';

import 'package:puzzle_hack/puzzle/domain/entities/square_puzzle_matrix.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/puzzle_item_bubble.dart';

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

class _PuzzleState extends State<Puzzle> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: Duration(seconds: 5));
  late final _turnAnimation = Tween<double>(begin: 0, end: 5).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PuzzleScreenBloc, PuzzleScreenState>(
      listener: (context, state) {
        if (state.isShuffling && !_controller.isAnimating) {
          _controller.forward();
        }
        if (!state.isShuffling && _controller.isAnimating) {
          _controller.reset();
        }
      },
      builder: (context, state) {
        return RotationTransition(
          turns: _turnAnimation,
          child: Stack(
            children: widget.matrix.points.map(
              (e) {
                final data = e.data;
                return AnimatedAlign(
                  curve: Curves.easeInOut,
                  key: Key(
                    data.toString(),
                  ),
                  alignment: FractionalOffset(
                    ((e.x) / (widget.matrix.order - 1)),
                    (e.y) / (widget.matrix.order - 1),
                  ),
                  duration: const Duration(milliseconds: 400),
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
          ),
        );
      },
    );
  }
}
