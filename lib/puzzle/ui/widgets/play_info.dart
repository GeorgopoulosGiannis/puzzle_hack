import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:puzzle_hack/puzzle/ui/widgets/info_entry.dart';

import '../pages/bloc/puzzle_screen_bloc.dart';

class PlayInfo extends StatelessWidget {
  const PlayInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PuzzleScreenBloc, PuzzleScreenState, Map<String, String>>(
      selector: (state) => {
        'tiles': state.correctNo.toString(),
        'moves': state.totalMoves.toString(),
      },
      builder: (context, map) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoEntry(
              text: '${map['moves']} Moves',
            ),
            InfoEntry(
              text: '${map['tiles']} Tiles',
            ),
          ],
        );
      },
    );
  }
}
