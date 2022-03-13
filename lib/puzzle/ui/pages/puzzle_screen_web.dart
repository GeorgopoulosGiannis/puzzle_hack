import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_hack/puzzle/domain/entities/square_puzzle_matrix.dart';

import 'package:puzzle_hack/puzzle/ui/widgets/play_info.dart';

import 'package:puzzle_hack/puzzle/ui/widgets/puzzle_board.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/shuffle_button.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/screen_background.dart';

import '../widgets/seconds_counter.dart';

import 'bloc/puzzle_screen_bloc.dart';

class PuzzleScreenWeb extends StatelessWidget {
  const PuzzleScreenWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ScreenBackground(),
        BlocSelector<PuzzleScreenBloc, PuzzleScreenState, bool>(
          selector: (state) => state.isShuffling,
          builder: (context, shuffling) {
            return AnimatedAlign(
              curve: Curves.easeInOut,
              duration: const Duration(seconds: 1),
              alignment: shuffling ? Alignment.center : Alignment.topCenter,
              child: const SecondsCounter(),
            );
          },
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ShuffleButton(),
                  PlayInfo(),
                ],
              ),
            ),
            BlocSelector<PuzzleScreenBloc, PuzzleScreenState, SquarePuzzleMatrix>(
                selector: (state) => state.puzzleMatrix,
                builder: (context, matrix) {
                  return AnimatedBuilder(
                    animation: matrix,
                    builder: (ctx, _) => Center(
                      child: PuzzleBoard(
                        matrix: matrix,
                      ),
                    ),
                  );
                }),
            const Spacer(
              flex: 1,
            )
          ],
        ),
        BlocSelector<PuzzleScreenBloc, PuzzleScreenState, bool>(
          selector: (state) => state.isCompleted,
          builder: (context, completed) {
            return AnimatedSwitcher(
              duration: const Duration(seconds: 2),
              child: !completed
                  ? const SizedBox.shrink()
                  : const Center(
                      child: Text(
                        'Congratulations!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 100,
                          shadows: [
                            Shadow(
                              color: Colors.white,
                              blurRadius: 10,
                            )
                          ],
                        ),
                      ),
                    ),
            );
          },
        )
      ],
    );
  }
}
