import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/bloc/puzzle_screen_bloc.dart';

class SecondsCounter extends StatefulWidget {
  const SecondsCounter({Key? key}) : super(key: key);

  @override
  State<SecondsCounter> createState() => _SecondsCounterState();
}

class _SecondsCounterState extends State<SecondsCounter> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: Duration(
      milliseconds: 900,
    ),
  );
  late final _opacity = Tween<double>(begin: 0.2, end: 1).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PuzzleScreenBloc, PuzzleScreenState>(
      listenWhen: (previous, current) =>
          (previous.secondsToGo == 0 && current.secondsToGo > 0) ||
          (previous.secondsToGo > 0 && current.secondsToGo == 0),
      listener: (context, state) {
        if (state.secondsToGo == 0) {
          _controller.reset();
        } else if (!_controller.isAnimating) {
          _controller.forward();
        }
      },
      builder: (context, state) {
        final isVisible = state.secondsToGo > 0;
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 800),
          child: Text(
            state.secondsToGo.toString(),
            key: Key(state.secondsToGo.toString()),
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
