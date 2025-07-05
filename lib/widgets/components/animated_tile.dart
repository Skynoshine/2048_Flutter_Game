
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:game/widgets/tile_widget.dart';

class AnimatedTile extends StatelessWidget {
  final int value;
  final AnimationController animationController;
  final double delay;

  const AnimatedTile({
    super.key,
    required this.value,
    required this.animationController,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        final delayedValue = math.max(0.0, animationController.value - delay);
        final slideValue = math.min(1.0, delayedValue * 3);

        return Transform.scale(
          scale: 1.0 + (slideValue * (1 - slideValue) * 0.05),
          child: TileWidget(value: value),
        );
      },
    );
  }
}