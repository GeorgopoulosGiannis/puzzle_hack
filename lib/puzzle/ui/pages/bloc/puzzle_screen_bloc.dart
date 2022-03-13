import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';
import 'package:puzzle_hack/core/audio/bloc/audio_player_bloc.dart';

import '../../../domain/entities/point.dart';
import '../../../domain/entities/square_puzzle_matrix.dart';

part 'puzzle_screen_event.dart';
part 'puzzle_screen_state.dart';

class PuzzleScreenBloc extends Bloc<PuzzleScreenEvent, PuzzleScreenState> {
  final AudioPlayerBloc audioBloc;
  final stopWatch = Stopwatch();
  Timer? timer;

  Future<void> playAudio() async {
    audioBloc.add(PlayTapEvent());
  }

  Future<void> playSuccess() async {
    audioBloc.add(PlaySuccessEvent());
  }

  PuzzleScreenBloc(this.audioBloc)
      : super(
          PuzzleScreenState(
            timePassed: Duration.zero.toString().substring(2, 7),
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
    on<StartStopWatch>(_onStartStopWatch);
    on<StopwatchTickEvent>(_onStopWatchTickEvent);
    on<StopStopWatch>(_onStopStopWatch);
  }

  FutureOr<void> _onShuffleEvent(
    ShuffleEvent event,
    Emitter<PuzzleScreenState> emit,
  ) async {
    add(StopStopWatch());
    emit(
      state.copyWith(
        isPlaying: false,
        isShuffling: true,
        totalMoves: 0,
        correctNo: 0,
        timePassed: Duration.zero.toString().substring(2, 7),
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
      if (state.isCompleted) {
        playSuccess();
        add(StopStopWatch());
      } else {
        playAudio();
      }
    }
  }

  FutureOr<void> _onStartPlayingEvent(
    StartPlayingEvent event,
    Emitter<PuzzleScreenState> emit,
  ) {
    add(StartStopWatch());
    emit(
      state.copyWith(
        isPlaying: true,
      ),
    );
  }

  FutureOr<void> _onStartStopWatch(
    StartStopWatch event,
    Emitter<PuzzleScreenState> emit,
  ) {
    stopWatch.reset();
    stopWatch.start();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        add(StopwatchTickEvent());
      },
    );
  }

  FutureOr<void> _onStopWatchTickEvent(
    StopwatchTickEvent event,
    Emitter<PuzzleScreenState> emit,
  ) {
    emit(
      state.copyWith(
        timePassed: stopWatch.elapsed.toString().substring(
              2,
              7,
            ),
      ),
    );
  }

  FutureOr<void> _onStopStopWatch(
    StopStopWatch event,
    Emitter<PuzzleScreenState> emit,
  ) {
    timer?.cancel();
    stopWatch.reset();
  }
}
