import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:puzzle_hack/puzzle/ui/widgets/puzzle_item_bubble.dart';
import 'package:puzzle_hack/puzzle/ui/widgets/whirlwind.dart';

import '../pages/bloc/puzzle_screen_bloc.dart';
import 'liquid_background.dart';

class ScreenBackground extends StatefulWidget {
  final VoidCallback cb;
  const ScreenBackground(
    this.cb, {
    Key? key,
  }) : super(key: key);

  @override
  State<ScreenBackground> createState() => _ScreenBackgroundState();
}

class _ScreenBackgroundState extends State<ScreenBackground> with SingleTickerProviderStateMixin {
  final rng = Random();

  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 1,
    ),
  )..repeat();

  late final screenSize = MediaQuery.of(context).size;

  List<double> initList(int length) => List.generate(length, (index) => 0);
  int length = 50;
  late List<double> b = initList(length);
  late List<double> l = initList(length);
  late List<double> s = initList(length);

  List<double> randomFrugality = [];

  @override
  void initState() {
    tickBounce();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  Future<void> explode() async {
    const newlength = 50;
    b = initList(newlength);
    l = initList(newlength);
    s = initList(newlength);

    setState(() {});
    Future.delayed(const Duration(milliseconds: 400)).then(
      (value) {
        for (var i = 0; i < s.length / 2; i++) {
          b[i] = rng.nextInt(screenSize.height.toInt()).toDouble();

          l[i] = rng.nextInt(screenSize.width.toInt()).toDouble();
          s[i] = rng.nextInt(70).toDouble();
        }

        setState(() {});
      },
    );
    Future.delayed(const Duration(seconds: 4)).then(
      (value) => reset(),
    );
  }

  Timer? timer;

  void tickBounce() {
    int i = 0;
    timer = Timer.periodic(
      Duration(milliseconds: 500),
      (timer) {
        i++;
        if (i == s.length) {
          i = 0;
          reset();
        }

        b[i] = screenSize.height + 40;
        l[i] = rng.nextInt(screenSize.width.toInt()).toDouble();
        s[i] = rng.nextInt(70).toDouble();

        setState(() {});
      },
    );
  }

  void reset() {
    b = initList(s.length);
    l = initList(s.length);
    s = initList(s.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PuzzleScreenBloc, PuzzleScreenState>(
      listener: (context, state) {
        if (state.isShuffling) {}
      },
      builder: (context, state) {
        return Stack(
          children: [
            const Liquid(),
            for (var i = 0; i < s.length; i++)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return _RandomBubble(
                    screenSize: screenSize,
                    key: Key('bubble_$i'),
                    endB: b[i],
                    endL: l[i],
                    endS: s[i],
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class _RandomBubble extends StatelessWidget {
  final Size screenSize;
  final double endB;
  final double endL;
  final double endS;

  const _RandomBubble({
    Key? key,
    required this.screenSize,
    required this.endB,
    required this.endL,
    required this.endS,
  }) : super(key: key);

  Widget _buildPositioned() {
    return AnimatedPositioned(
        curve: Curves.decelerate,
        duration: const Duration(seconds: 4),
        bottom: endB,
        left: endL,
        child: endS > 0
            ? SizedBox(
                height: endS,
                width: endS,
                child: CustomPaint(
                  painter: BackgroundBubble(),
                  foregroundPainter: BubblePainter(),
                ),
              )
            : const SizedBox.shrink());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          _buildPositioned(),
        ],
      ),
    );
  }
}
