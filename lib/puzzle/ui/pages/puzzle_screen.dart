import 'package:flutter/material.dart';
import 'package:puzzle_hack/puzzle/domain/entities/is_solvable.dart';
import 'package:puzzle_hack/puzzle/domain/entities/square_puzzle_matrix.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/correct_tiles.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/moves.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/puzzle.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/shuffle_button.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({Key? key}) : super(key: key);

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  late final puzzleMatrix = SquarePuzzleMatrix.generate(4);
  bool holdingBtn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFEFEEEE),
          ),
          padding: const EdgeInsets.all(8.0),
          child: AnimatedBuilder(
            animation: puzzleMatrix,
            builder: (ctx, _) => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            print(isSolvable(
                                puzzleMatrix.points.fold<List<int?>>(
                                    [],
                                    (prev, cur) => [
                                          ...prev,
                                          cur.isBlank
                                              ? null
                                              : int.parse(cur.data!)
                                        ]),
                                puzzleMatrix.order));
                          },
                          child: const Text('check solvability')),
                      ShuffleButton(
                        onTap: () async {
                          puzzleMatrix.shuffle();
                        },
                      ),
                      Moves(
                        totalMoves: puzzleMatrix.totalMoves,
                      ),
                      CorrectTiles(
                        puzzleMatrix.correctlyPlacedTiles,
                      ),
                    ],
                  ),
                ),
                Puzzle(
                  matrix: puzzleMatrix,
                ),
                const Spacer(
                  flex: 1,
                )
              ],
            ),
          )),
    );
  }
}
