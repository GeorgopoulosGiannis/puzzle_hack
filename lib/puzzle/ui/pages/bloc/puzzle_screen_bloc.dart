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
            correctNo: 0,
            totalMoves: 0,
            isShuffling: true,
            puzzleMatrix: SquarePuzzleMatrix.generate(4),
          ),
        ) {
    _registerEvents();
  }

  void _registerEvents() {
    on<ShuffleEvent>(_onShuffleEvent);
    on<PointTapEvent>(_onPointTapEvent);
  }

  FutureOr<void> _onShuffleEvent(
    ShuffleEvent event,
    Emitter<PuzzleScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        isShuffling: true,
        totalMoves: 0,
        correctNo: 0,
      ),
    );
    await state.puzzleMatrix.shuffle();
    emit(
      state.copyWith(
        isShuffling: false,
        correctNo: state.puzzleMatrix.correctlyPlacedTiles,
      ),
    );
  }

  FutureOr<void> _onPointTapEvent(
    PointTapEvent event,
    Emitter<PuzzleScreenState> emit,
  ) {
    final moved = state.puzzleMatrix.onPointTap(event.point);
    if (moved) {
      emit(
        state.copyWith(
          totalMoves: state.puzzleMatrix.totalMoves,
          correctNo: state.puzzleMatrix.correctlyPlacedTiles,
        ),
      );
    }
  }
}
