import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:puzzle_hack/puzzle/ui/widgets/puzzle_item_bubble.dart';

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

  Timer? timer;

  void tickBounce() {
    int i = 0;
    timer = Timer.periodic(
      const Duration(milliseconds: 500),
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
  Widget build(BuildContext context) => BlocBuilder<PuzzleScreenBloc, PuzzleScreenState>(
        builder: (context, state) => Stack(
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
        ),
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

  Widget _buildPositioned() {
    return AnimatedPositioned(
      onEnd: () {
        if (controller.isCompleted) {
          controller.reset();
        }
        if (widget.endB > 0) {
          showSplash = true;
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

class Splash extends StatelessWidget {
  final double radius;
  final double bottom;
  final double left;
  final AnimationController controller;

  Splash({
    Key? key,
    required this.radius,
    required this.bottom,
    required this.left,
    required this.controller,
  }) : super(key: key);

  late final radiusTween = Tween<double>(
    begin: 0,
    end: radius,
  );
  final Tween<double> borderWidthTween = Tween<double>(
    begin: 25,
    end: 1,
  );
  late final Animation<double> radiusAnimation = radiusTween.animate(
    CurvedAnimation(
      curve: Curves.ease,
      parent: controller,
    ),
  );
  late final Animation<double> borderWidthAnimation = borderWidthTween.animate(
    CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: controller,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return CustomPaint(
            foregroundPainter: _Splash(
              radius: radiusAnimation.value,
              borderWidth: borderWidthAnimation.value,
              color: Colors.white,
            ),
          );
        });
  }
}

class _Splash extends CustomPainter {
  _Splash({
    required this.radius,
    required this.borderWidth,
    required this.color,
  }) : blackPaint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth;

  final double radius;
  final double borderWidth;

  final Color color;
  final Paint blackPaint;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset.zero, radius, blackPaint);
  }

  @override
  bool shouldRepaint(_Splash oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.borderWidth != borderWidth;
  }
}
