part of 'audio_player_bloc.dart';

abstract class AudioPlayerState extends Equatable {
  const AudioPlayerState();
  
  @override
  List<Object> get props => [];
}

class AudioPlayerInitial extends AudioPlayerState {}
