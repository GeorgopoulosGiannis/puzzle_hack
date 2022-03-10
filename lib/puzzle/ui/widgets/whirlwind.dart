import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'puzzle_item_bubble.dart';

class Whirlwind extends StatefulWidget {
  const Whirlwind({Key? key}) : super(key: key);

  @override
  State<Whirlwind> createState() => _WhirlwindState();
}

final rndm = List.generate(10, (index) => Random(20).nextInt(200) * index);

final rndm2 = List.generate(10, (index) => Random(20).nextInt(200) * index);
final rndm3 = List.generate(10, (index) => Random().nextInt(50));

class _WhirlwindState extends State<Whirlwind> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat(); //..forward();
  late final _turnAnimation = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ),
  );
  late final _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  //late final heightFirst = Tween<double>(begin: )
  final rand = <List<int>>[];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    generateRandom();
  }

  Future<void> generateRandom() async {
    final rng = Random();
    final size = MediaQuery.of(context).size;
    final height = (size.height * 0.2).toInt();
    final width = (size.width * 0.3).toInt();

    for (int i = 0; i < 10; i++) {
      rand.add(
        [
          rng.nextInt(height),
          rng.nextInt(width),
          rng.nextInt(
            40,
          ),
        ],
      );
    }
    for (int i = 0; i < 10; i++) {
      rand.add(
        [
          (size.height / 2 - rng.nextInt(height + 20)).toInt(),
          (size.width - rng.nextInt(width + 20)).toInt(),
          rng.nextInt(
            40,
          ),
        ],
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _turnAnimation,
      builder: (context, child) => Transform.rotate(
        angle: _turnAnimation.value,
        child: child,
      ),
      child: Stack(
        children: [
          for (int i = 0; i < rand.length; i++)
            AnimatedPositioned(
              duration: Duration.zero,
              top: rand[i][0].toDouble(),
              left: rand[i][1].toDouble(),
              height: 40,
              width: 40,
              child: CustomPaint(
                painter: BackgroundBubble(),
                foregroundPainter: BubblePainter(),
              ),
            )
        ],
      ),
    );
  }
}

class WhilrwindPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = Colors.white;
    for (var i = 0; i < rndm.length; i++) {
      canvas.drawCircle(
        Offset(rndm[i].toDouble(), rndm2[i].toDouble()),
        10,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
