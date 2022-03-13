import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:puzzle_hack/puzzle/ui/widgets/puzzle_item_bubble.dart';
import 'liquid_background.dart';
import 'splash.dart';

class ScreenBackground extends StatefulWidget {
  const ScreenBackground({
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

  Timer? timer;

  void tickBounce() {
    int i = 0;
    timer = Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) {
        i++;
        if (i == s.length) {
          i = 0;
        }

        b[i] = rng.nextInt(screenSize.height.toInt()).toDouble();
        l[i] = rng.nextInt(screenSize.width.toInt()).toDouble();
        s[i] = rng.nextInt(70).toDouble();

        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) => Stack(
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
                    cb: () {
                      b[i] = 0;
                      l[i] = 0;
                      s[i] = 0;
                    });
              },
            ),
        ],
      );
}

class _RandomBubble extends StatefulWidget {
  final Size screenSize;
  final double endB;
  final double endL;
  final double endS;
  final VoidCallback cb;

  const _RandomBubble({
    Key? key,
    required this.cb,
    required this.screenSize,
    required this.endB,
    required this.endL,
    required this.endS,
  }) : super(key: key);

  @override
  State<_RandomBubble> createState() => _RandomBubbleState();
}

class _RandomBubbleState extends State<_RandomBubble> with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 350,
    ),
  )..addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          showSplash = false;
          widget.cb();
        }
      },
    );

  bool showSplash = false;
  final player = AudioPlayer()..setVolume(0.5);
  Future<void> playAudio() async {
    await player.setFilePath('assets/audio/splash.mp3');
    await player.play();
  }

  Widget _buildPositioned() {
    return AnimatedPositioned(
      onEnd: () {
        if (controller.isCompleted) {
          controller.reset();
        }
        if (widget.endB > 0) {
          showSplash = true;
          playAudio();
          controller.forward();
        }
      },
      curve: Curves.decelerate,
      duration: const Duration(seconds: 4),
      bottom: widget.endB,
      left: widget.endL,
      child: showSplash
          ? Splash(
              left: widget.endL,
              bottom: widget.endB,
              radius: widget.endS,
              controller: controller,
            )
          : widget.endS == 0
              ? const SizedBox.shrink()
              : SizedBox(
                  height: widget.endS,
                  width: widget.endS,
                  child: CustomPaint(
                    painter: BackgroundBubble(),
                    foregroundPainter: BubblePainter(),
                  ),
                ),
    );
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
