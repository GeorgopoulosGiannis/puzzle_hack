import 'package:flutter/material.dart';

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
