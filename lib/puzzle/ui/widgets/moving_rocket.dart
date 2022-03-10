import 'package:flutter/material.dart';

class MovingRocket extends StatefulWidget {
  const MovingRocket({Key? key}) : super(key: key);

  @override
  State<MovingRocket> createState() => _MovingRocketState();
}

class _MovingRocketState extends State<MovingRocket> with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    duration: const Duration(
      seconds: 20,
    ),
    vsync: this,
  )..repeat();

  @override
  Widget build(BuildContext context) {
    return _Rocket(
      controller: controller,
    );
  }
}

class _Rocket extends StatelessWidget {
  final AnimationController controller;

  _Rocket({Key? key, required this.controller}) : super(key: key);

  late final Animation<Offset> move1 = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(
      3.0,
      0.0,
    ),
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.0,
        0.200,
        curve: Curves.linear,
      ),
    ),
  );

  late final Animation<Offset> move2 = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(
      0.0,
      3.0,
    ),
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.250,
        0.450,
        curve: Curves.linear,
      ),
    ),
  );

  late final Animation<Offset> move3 = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(
      -3.0,
      0.0,
    ),
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.500,
        0.700,
        curve: Curves.linear,
      ),
    ),
  );

  late final Animation<Offset> move4 = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(
      0.0,
      -3.0,
    ),
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.750,
        0.950,
        curve: Curves.linear,
      ),
    ),
  );
  late final Animation<double> rotate1 = Tween<double>(
    begin: 0.0,
    end: 0.25,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.200,
        0.250,
        curve: Curves.ease,
      ),
    ),
  );
  late final Animation<double> rotate2 = Tween<double>(
    begin: 0.5,
    end: 0.75,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.450,
        0.500,
        curve: Curves.ease,
      ),
    ),
  );
  late final Animation<double> rotate3 = Tween<double>(
    begin: 0.75,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.700,
        0.750,
        curve: Curves.ease,
      ),
    ),
  );
  late final Animation<double> rotate4 = Tween<double>(
    begin: 0.0,
    end: 0.25,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.950,
        1.0,
        curve: Curves.ease,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: move1,
      child: SlideTransition(
        position: move2,
        child: SlideTransition(
          position: move3,
          child: SlideTransition(
            position: move4,
            child: RotationTransition(
              turns: rotate1,
              child: RotationTransition(
                turns: rotate2,
                child: RotationTransition(
                  turns: rotate3,
                  child: RotationTransition(
                    turns: rotate4,
                    child: Image.asset(
                      'assets/spaceship.png',
                      scale: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
