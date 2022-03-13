import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/point.dart';
import '../../../domain/entities/square_puzzle_matrix.dart';

part 'puzzle_screen_event.dart';
part 'puzzle_screen_state.dart';

class PuzzleScreenBloc extends Bloc<PuzzleScreenEvent, PuzzleScreenState> {
  late AudioPlayer player = AudioPlayer();

  Future<void> playAudio() async {
    await player.setFilePath('assets/audio/tile_move.mp3');
    player.play();
  }

  PuzzleScreenBloc()
      : super(
          PuzzleScreenState(
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
      playAudio();
      emit(
        state.copyWith(
          puzzleMatrix: puzzle,
          totalMoves: state.puzzleMatrix.totalMoves,
          correctNo: 16, //state.puzzleMatrix.correctlyPlacedTiles,
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
