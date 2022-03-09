import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/bloc/puzzle_screen_bloc.dart';

class CorrectTiles extends StatelessWidget {
  const CorrectTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzleScreenBloc, PuzzleScreenState>(
      builder: (context, state) {
        return Text(
          '${state.correctNo} Tiles',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
