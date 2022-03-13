import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/bloc/puzzle_screen_bloc.dart';

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: BlocSelector<PuzzleScreenBloc, PuzzleScreenState, bool>(
        selector: (state) => state.isPlaying,
        builder: (context, isPlaying) {
          return TextButton.icon(
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                );
              }),
              padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const EdgeInsets.all(20);
                  }
                  return const EdgeInsets.all(15);
                },
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.purple;
                  }
                  return Colors.blue;
                },
              ),
            ),
            onPressed: !isPlaying
                ? null
                : () => context.read<PuzzleScreenBloc>().add(
                      ShuffleEvent(),
                    ),
            icon: BlocSelector<PuzzleScreenBloc, PuzzleScreenState, bool>(
              selector: (state) => state.isCompleted,
              builder: (context, completed) {
                return Icon(
                  completed ? Icons.replay : Icons.shuffle,
                  color: Colors.white,
                  size: 30,
                );
              },
            ),
            label: BlocSelector<PuzzleScreenBloc, PuzzleScreenState, bool>(
              selector: (state) => state.isCompleted,
              builder: (context, completed) {
                return Text(
                  completed ? 'Replay' : 'Shuffle',
                  style: const TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
