part of 'puzzle_screen_bloc.dart';

@immutable
class PuzzleScreenState extends Equatable {
  final SquarePuzzleMatrix puzzleMatrix;
  final bool isShuffling;
  final int totalMoves;
  final int correctNo;
  final bool isPlaying;
  final int secondsToGo;
  const PuzzleScreenState({
    required this.totalMoves,
    required this.isShuffling,
    required this.puzzleMatrix,
    required this.correctNo,
    required this.isPlaying,
    required this.secondsToGo,
  });

  @override
  List<Object?> get props => [
        puzzleMatrix,
        isShuffling,
        totalMoves,
        correctNo,
        isPlaying,
        secondsToGo,
      ];

  PuzzleScreenState copyWith({
    SquarePuzzleMatrix? puzzleMatrix,
    bool? isShuffling,
    int? totalMoves,
    int? correctNo,
    bool? isPlaying,
    int? secondsToGo,
  }) =>
      PuzzleScreenState(
        secondsToGo: secondsToGo ?? 0,
        isPlaying: isPlaying ?? this.isPlaying,
        correctNo: correctNo ?? this.correctNo,
        totalMoves: totalMoves ?? this.totalMoves,
        isShuffling: isShuffling ?? this.isShuffling,
        puzzleMatrix: puzzleMatrix ?? this.puzzleMatrix,
      );
}
