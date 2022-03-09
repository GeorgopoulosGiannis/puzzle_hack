import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector_math;

import '../../domain/entities/point.dart';

const borderColor = Color.fromARGB(255, 0, 129, 146); // Color.fromARGB(255, 97, 160, 233);
const fillColor = Color(0xff00bcd4); // Color.fromARGB(255, 139, 203, 255);
const dotColor = Colors.white;

class PuzzleItemBubble extends StatelessWidget {
  final Point p;
  final VoidCallback? onPointTap;
  const PuzzleItemBubble({
    Key? key,
    required this.p,
    required this.onPointTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return p.isBlank
        ? const SizedBox.shrink()
        : GestureDetector(
            onTap: onPointTap,
            child: CustomPaint(
              painter: BackgroundBubble(),
              foregroundPainter: BubblePainter(),
              child: Center(
                child: Text(
                  p.data!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(255, 94, 173, 238),
                        blurRadius: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class BubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // sub-circle
    final paint = Paint()
      ..color = fillColor.withOpacity(0.7)
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;
    Path path0 = Path();
    path0.moveTo(
      size.width * 0.8,
      size.height * 0.2,
    );
    path0.quadraticBezierTo(
      size.width,
      size.height * 0.9,
      size.width * 0.35,
      size.height * 0.95,
    );

    path0.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.8,
      size.width * 0.8,
      size.height * 0.2,
    );

    canvas.drawPath(path0, paint);

    // halfmoon
    final paint3 = Paint()
      ..color = dotColor.withOpacity(0.8)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        2,
      )
      ..style = PaintingStyle.fill;

    Path path1 = Path();
    path1.moveTo(
      size.width * 0.54,
      size.height * 0.92,
    );
    path1.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.85,
      size.width * 0.83,
      size.height * 0.35,
    );

    path1.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.7,
      size.width * 0.6,
      size.height * 0.82,
    );
    path1.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.87,
      size.width * 0.54,
      size.height * 0.92,
    );

    canvas.drawPath(path1, paint3);

    // dot small
    final rect = Rect.fromLTWH(
      size.width * 0.3,
      size.height * 0.2,
      size.width * 0.1,
      size.height * 0.2,
    );

    // dot big
    final rect2 = Rect.fromLTWH(
      size.width * 0.33,
      -(size.height * 0.3),
      size.width * 0.15,
      size.height * 0.25,
    );

    final paint4 = Paint()
      ..color = dotColor.withOpacity(0.9)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        2,
      )
      ..style = PaintingStyle.fill;

    canvas.rotate(vector_math.radians(20));
    canvas.drawOval(rect, paint4);
    canvas.rotate(vector_math.radians(25));
    canvas.drawOval(rect2, paint4);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BackgroundBubble extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Fill color
    final paint = Paint()
      ..color = fillColor.withOpacity(0.7)
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 3 + 10,
      paint,
    );

    /// Border
    final paint1 = Paint()
      ..color = borderColor.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 3 + 10,
      paint1,
    );

    /// Shadow
    final shadowPaint = Paint()
      ..color = Colors.white
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.outer,
        15,
      );

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 3 + 10,
      shadowPaint,
    );

    /// Inside light circle
    final paint2 = Paint()
      ..color = dotColor.withOpacity(0.6)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        2,
      )
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2 + 3, size.height / 2 + 5),
      size.width / 4 + 5,
      paint2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
