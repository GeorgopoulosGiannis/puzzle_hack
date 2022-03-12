import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/point.dart';
import '../../../domain/entities/square_puzzle_matrix.dart';

part 'puzzle_screen_event.dart';
part 'puzzle_screen_state.dart';

class PuzzleScreenBloc extends Bloc<PuzzleScreenEvent, PuzzleScreenState> {
  PuzzleScreenBloc()
      : super(
          PuzzleScreenState(
            secondsToGo: 0,
            isPlaying: false,
            correctNo: 0,
            totalMoves: 0,
            isShuffling: false,
            puzzleMatrix: SquarePuzzleMatrix.generate(4),
          ),
        ) {
    _registerEvents();
  }

  void _registerEvents() {
    on<ShuffleEvent>(_onShuffleEvent);
    on<PointTapEvent>(_onPointTapEvent);
    on<StartPlayingEvent>(_onStartPlayingEvent);
  }

  FutureOr<void> _onShuffleEvent(
    ShuffleEvent event,
    Emitter<PuzzleScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        isPlaying: false,
        isShuffling: true,
        totalMoves: 0,
        correctNo: 0,
      ),
    );
    final puzzle = state.puzzleMatrix;
    await puzzle.shuffle();
    emit(
      state.copyWith(
        puzzleMatrix: puzzle,
        isShuffling: false,
        correctNo: state.puzzleMatrix.correctlyPlacedTiles,
      ),
    );
  }

  FutureOr<void> _onPointTapEvent(
    PointTapEvent event,
    Emitter<PuzzleScreenState> emit,
  ) {
    final puzzle = state.puzzleMatrix;
    final moved = puzzle.onPointTap(event.point);
    if (moved) {
      emit(
        state.copyWith(
          puzzleMatrix: puzzle,
          totalMoves: state.puzzleMatrix.totalMoves,
          correctNo: state.puzzleMatrix.correctlyPlacedTiles,
        ),
      );
    }
  }

  FutureOr<void> _onStartPlayingEvent(
    StartPlayingEvent event,
    Emitter<PuzzleScreenState> emit,
  ) {
    emit(
      state.copyWith(
        isPlaying: true,
      ),
    );
  }
}
