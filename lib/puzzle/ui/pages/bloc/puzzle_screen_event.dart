part of 'puzzle_screen_bloc.dart';

@immutable
abstract class PuzzleScreenEvent {}

class ShuffleEvent extends PuzzleScreenEvent {}

class PointTapEvent extends PuzzleScreenEvent {
  final Point point;

  PointTapEvent(this.point);
}

class StartCountdownEvent extends PuzzleScreenEvent {}

class StartPlayingEvent extends PuzzleScreenEvent {}

class NewSecondsEvent extends PuzzleScreenEvent {
  final int second;

  NewSecondsEvent(this.second);
}
