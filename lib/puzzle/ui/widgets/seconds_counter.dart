import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/bloc/puzzle_screen_bloc.dart';

class SecondsCounter extends StatefulWidget {
  const SecondsCounter({Key? key}) : super(key: key);

  @override
  State<SecondsCounter> createState() => _SecondsCounterState();
}

class _SecondsCounterState extends State<SecondsCounter> {
  Timer? timer;
  int curSecond = 0;

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
          if (curSecond == 0) {
            timer.cancel();
            context.read<PuzzleScreenBloc>().add(StartPlayingEvent());
          }
          setState(() {});
        });
      },
      builder: (context, state) {
        final isVisible = curSecond > 0;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          child: Text(
            curSecond.toString(),
            key: Key(curSecond.toString()),
            style: TextStyle(
              color: isVisible ? Colors.white : Colors.transparent,
              fontSize: 100,
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
        );
      },
    );
  }
}
