import 'package:flutter/material.dart';
import 'package:sa3_liquid/sa3_liquid.dart';

class Liquid extends StatelessWidget {
  const Liquid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff00bcd4),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: const PlasmaRenderer(
        type: PlasmaType.bubbles,
        particles: 27,
        color: Color(0x44ffffff),
        blur: 0,
        size: 0.51,
        speed: 4.5,
        offset: 0,
        blendMode: BlendMode.screen,
        particleType: ParticleType.atlas,
        variation1: 0.31,
        variation2: 0.3,
        variation3: 0.13,
        rotation: 1.05,
        child: PlasmaRenderer(
          type: PlasmaType.bubbles,
          particles: 27,
          color: Color(0x44ffffff),
          blur: 0,
          size: 0.51,
          speed: 1.11,
          offset: 0,
          blendMode: BlendMode.screen,
          particleType: ParticleType.atlas,
          variation1: 0.31,
          variation2: 0.3,
          variation3: 0.13,
          rotation: 1.05,
          child: PlasmaRenderer(
            type: PlasmaType.bubbles,
            particles: 27,
            color: Color(0x44ffffff),
            blur: 0.39,
            size: 0.51,
            speed: 2.4,
            offset: 0,
            blendMode: BlendMode.screen,
            particleType: ParticleType.atlas,
            variation1: 0.31,
            variation2: 0.3,
            variation3: 0.13,
            rotation: 1.05,
          ),
        ),
      ),
    );
  }
}
