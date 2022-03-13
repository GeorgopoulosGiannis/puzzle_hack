part of 'audio_player_bloc.dart';

abstract class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();

  @override
  List<Object> get props => [];
}

class PlaySplashEvent extends AudioPlayerEvent {}

class PlayTapEvent extends AudioPlayerEvent {}

class PlayGoEvent extends AudioPlayerEvent {}

class PlayTickEvent extends AudioPlayerEvent {}

class PlaySuccessEvent extends AudioPlayerEvent {}

class StopEvent extends AudioPlayerEvent {}
