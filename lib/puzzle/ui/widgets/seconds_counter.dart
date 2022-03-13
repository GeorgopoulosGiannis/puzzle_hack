import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:puzzle_hack/core/audio/bloc/audio_player_bloc.dart';
import 'package:puzzle_hack/core/widgets/responsive_layout_builder.dart';

import '../pages/bloc/puzzle_screen_bloc.dart';

class SecondsCounter extends StatefulWidget {
  const SecondsCounter({Key? key}) : super(key: key);

  @override
  State<SecondsCounter> createState() => _SecondsCounterState();
}

class _SecondsCounterState extends State<SecondsCounter> {
  Timer? timer;
  int curSecond = -1;

  Future<void> playAudio() async {
    context.read<AudioPlayerBloc>().add(PlayTickEvent());
  }

  Future<void> playStartAudio() async {
    context.read<AudioPlayerBloc>().add(PlayGoEvent());
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PuzzleScreenBloc, PuzzleScreenState>(
      listenWhen: (previous, current) => (!previous.isShuffling && current.isShuffling),
      listener: (context, state) {
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          curSecond = 4 - timer.tick;
          if (curSecond == -1) {
            context.read<AudioPlayerBloc>().add(StopEvent());

            timer.cancel();
            context.read<PuzzleScreenBloc>().add(StartPlayingEvent());
          } else if (curSecond == 0) {
            playStartAudio();
          } else {
            playAudio();
          }
          setState(() {});
        });
      },
      builder: (context, state) {
        final isVisible = curSecond >= 0;
        final text = curSecond == 0 ? 'GO!' : curSecond.toString();
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 700),
          transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          ),
          child: ResponsiveLayoutBuilder(
            small: (context, child) => Text(
              text,
              key: Key(curSecond.toString()),
              style: TextStyle(
                color: isVisible ? Colors.white : Colors.transparent,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                shadows: isVisible
                    ? const [
                        Shadow(
                          color: Colors.white,
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
            ),
            medium: (context, child) => Text(
              text,
              key: Key(curSecond.toString()),
              style: TextStyle(
                color: isVisible ? Colors.white : Colors.transparent,
                fontSize: 60,
                fontWeight: FontWeight.bold,
                shadows: isVisible
                    ? const [
                        Shadow(
                          color: Colors.white,
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
            ),
            large: (context, child) => Text(
              text,
              key: Key(curSecond.toString()),
              style: TextStyle(
                color: isVisible ? Colors.white : Colors.transparent,
                fontSize: 150,
                fontWeight: FontWeight.bold,
                shadows: isVisible
                    ? const [
                        Shadow(
                          color: Colors.white,
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
