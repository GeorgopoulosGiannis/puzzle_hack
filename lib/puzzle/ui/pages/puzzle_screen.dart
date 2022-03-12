import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:puzzle_hack/puzzle/ui/widgets/correct_tiles.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/moves.dart';

import 'package:puzzle_hack/puzzle/ui/widgets/puzzle_board.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/shuffle_button.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/screen_background.dart';

import '../widgets/seconds_counter.dart';
import 'bloc/puzzle_screen_bloc.dart';

class PuzzleScreen extends StatelessWidget {
  const PuzzleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PuzzleScreenBloc(), //..add(ShuffleEvent()),
      child: BlocBuilder<PuzzleScreenBloc, PuzzleScreenState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                ScreenBackground(
                  () {
                    context.read<PuzzleScreenBloc>().add(ShuffleEvent());
                  },
                ),
                AnimatedBuilder(
                  animation: state.puzzleMatrix,
                  builder: (ctx, _) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SecondsCounter(),
                            ShuffleButton(
                              onTap: () async {
                                context.read<PuzzleScreenBloc>().add(ShuffleEvent());
                              },
                            ),
                            const Moves(),
                            const CorrectTiles(),
                          ],
                        ),
                      ),
                      Center(
                        child: PuzzleBoard(
                          matrix: state.puzzleMatrix,
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
