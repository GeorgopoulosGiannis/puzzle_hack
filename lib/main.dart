import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock/wakelock.dart';

import 'core/audio/bloc/audio_player_bloc.dart';
import 'puzzle/ui/pages/bloc/puzzle_screen_bloc.dart';
import 'puzzle/ui/pages/puzzle_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    Wakelock.enable();
  }
  final audioBloc = AudioPlayerBloc();
  runApp(MyApp(
    audioBloc: audioBloc,
  ));
}

class MyApp extends StatelessWidget {
  final AudioPlayerBloc audioBloc;
  const MyApp({
    Key? key,
    required this.audioBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: audioBloc,
        ),
        BlocProvider(
          create: (context) => PuzzleScreenBloc(audioBloc)
            ..add(
              ShuffleEvent(),
            ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Puzzle Hack',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PuzzleScreen(),
      ),
    );
  }
}
