import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_hack/puzzle/domain/entities/square_puzzle_matrix.dart';

import 'package:puzzle_hack/puzzle/ui/widgets/puzzle_board.dart';

import 'package:puzzle_hack/puzzle/ui/widgets/screen_background.dart';

import '../widgets/play_info.dart';
import '../widgets/seconds_counter.dart';
import '../widgets/shuffle_button.dart';
import 'bloc/puzzle_screen_bloc.dart';

class PuzzleScreenMobile extends StatelessWidget {
  const PuzzleScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ScreenBackground(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                ShuffleButton(),
                PlayInfo(),
              ],
            ),
            const SecondsCounter(),
            BlocSelector<PuzzleScreenBloc, PuzzleScreenState, SquarePuzzleMatrix>(
              selector: (state) => state.puzzleMatrix,
              builder: (context, matrix) {
                return AnimatedBuilder(
                  animation: matrix,
                  builder: (ctx, _) => Align(
                    alignment: Alignment.bottomCenter,
                    child: PuzzleBoard(
                      matrix: matrix,
                    ),
                  ),
                );
              },
            ),
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
