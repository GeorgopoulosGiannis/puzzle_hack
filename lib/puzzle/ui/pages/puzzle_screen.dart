import 'package:flutter/material.dart';

import 'package:puzzle_hack/core/widgets/responsive_layout_builder.dart';

import 'package:puzzle_hack/puzzle/ui/pages/puzzle_screen_mobile.dart';
import 'package:puzzle_hack/puzzle/ui/pages/puzzle_screen_web.dart';

import 'puzzle_screen_tablet.dart';

class PuzzleScreen extends StatelessWidget {
  const PuzzleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayoutBuilder(
        small: (context, child) => const PuzzleScreenMobile(),
        medium: (context, child) => const PuzzleScreenTablet(),
        large: (context, child) => const PuzzleScreenWeb(),
      ),
    );
  }
}
