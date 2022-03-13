import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer player = AudioPlayer();
  final AudioPlayer player2 = AudioPlayer();

  AudioPlayerBloc() : super(AudioPlayerInitial()) {
    _registerEvents();
  }

  _registerEvents() {
    on<PlaySplashEvent>(_onPlaySplashEvent);
    on<PlayTapEvent>(_onPlayTapEvent);
    on<PlayGoEvent>(_onPlayGoEvent);
    on<PlayTickEvent>(_onPlayTickEvent);
    on<PlaySuccessEvent>(_onPlaySuccessEvent);
    on<StopEvent>(_onStopEvent);
  }

  FutureOr<void> _onPlaySplashEvent(
    PlaySplashEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await player.setAsset('assets/audio/splash.mp3');
    player.play();
  }

  FutureOr<void> _onPlayTapEvent(
    PlayTapEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await player.setAsset('assets/audio/tile_move.mp3');
    player.play();
  }

  FutureOr<void> _onPlayGoEvent(
    PlayGoEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await player.setAsset('assets/audio/start.mp3');
    player.play();
  }

  FutureOr<void> _onPlayTickEvent(
    PlayTickEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await player2.setAsset('assets/audio/click.mp3');
    player2.play();
  }

  FutureOr<void> _onPlaySuccessEvent(
    PlaySuccessEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await player.setAsset('assets/audio/success.mp3');
    player.play();
  }

  FutureOr<void> _onStopEvent(
    StopEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await player.pause();
    await player.seek(Duration.zero);
  }
}
