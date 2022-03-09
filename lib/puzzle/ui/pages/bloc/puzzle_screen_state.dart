part of 'puzzle_screen_bloc.dart';

@immutable
class PuzzleScreenState extends Equatable {
  final SquarePuzzleMatrix puzzleMatrix;
  final bool isShuffling;
  final int totalMoves;
  final int correctNo;
  const PuzzleScreenState({
    required this.totalMoves,
    required this.isShuffling,
    required this.puzzleMatrix,
    required this.correctNo,
  });

  @override
  List<Object?> get props => [
        puzzleMatrix,
        isShuffling,
        totalMoves,
        correctNo,
      ];

  PuzzleScreenState copyWith({
    SquarePuzzleMatrix? puzzleMatrix,
    bool? isShuffling,
    int? totalMoves,
    int? correctNo,
  }) =>
      PuzzleScreenState(
        correctNo: correctNo ?? this.correctNo,
        totalMoves: totalMoves ?? this.totalMoves,
        isShuffling: isShuffling ?? this.isShuffling,
        puzzleMatrix: puzzleMatrix ?? this.puzzleMatrix,
      );
}
