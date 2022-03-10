import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import 'puzzle/ui/pages/puzzle_screen.dart';

void main() {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    Wakelock.enable();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Puzzle Hack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PuzzleScreen(),
    );
  }
}
