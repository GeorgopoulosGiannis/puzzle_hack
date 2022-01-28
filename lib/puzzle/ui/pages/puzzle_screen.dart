import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.white12,
              Colors.blue,
            ],
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShuffleButton(
                    onTap: () async {
                      for (var i = 0; i < 10; i++) {
                        puzzleMatrix.shuffle();
                        setState(() {});
                        await Future.delayed(const Duration(milliseconds: 250));
                      }
                    },
                  ),
                  const Moves(),
                  const CorrectTiles(),
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
      ),
    );
  }
}
