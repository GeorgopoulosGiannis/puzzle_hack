part of 'puzzle_screen_bloc.dart';

@immutable
class PuzzleScreenState extends Equatable {
  final SquarePuzzleMatrix puzzleMatrix;
  final bool isShuffling;
  final int totalMoves;
  final int correctNo;
  final bool isPlaying;
  final String timePassed;

  bool get isCompleted => correctNo == puzzleMatrix.order * puzzleMatrix.order && isPlaying;

  const PuzzleScreenState({
    required this.timePassed,
    required this.totalMoves,
    required this.isShuffling,
    required this.puzzleMatrix,
    required this.correctNo,
    required this.isPlaying,
  });

  @override
  List<Object?> get props => [
        puzzleMatrix,
        isShuffling,
        totalMoves,
        correctNo,
        isPlaying,
        timePassed,
      ];

  PuzzleScreenState copyWith({
    SquarePuzzleMatrix? puzzleMatrix,
    bool? isShuffling,
    int? totalMoves,
    int? correctNo,
    bool? isPlaying,
    Stopwatch? stopwatch,
    String? timePassed,
  }) =>
      PuzzleScreenState(
        timePassed: timePassed ?? this.timePassed,
        isPlaying: isPlaying ?? this.isPlaying,
        correctNo: correctNo ?? this.correctNo,
        totalMoves: totalMoves ?? this.totalMoves,
        isShuffling: isShuffling ?? this.isShuffling,
        puzzleMatrix: puzzleMatrix ?? this.puzzleMatrix,
      );
}
