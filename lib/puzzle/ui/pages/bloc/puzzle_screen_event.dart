part of 'puzzle_screen_bloc.dart';

@immutable
abstract class PuzzleScreenEvent {}

class ShuffleEvent extends PuzzleScreenEvent {}

class PointTapEvent extends PuzzleScreenEvent {
  final Point point;

  PointTapEvent(this.point);
}

class StartPlayingEvent extends PuzzleScreenEvent {}

class StartStopWatch extends PuzzleScreenEvent {}

class StopStopWatch extends PuzzleScreenEvent {}

class StopwatchTickEvent extends PuzzleScreenEvent {}
