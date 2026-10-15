import 'dart:math' as math;

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class SpinningScallopIndicator extends StatefulWidget {
  final int lobes;
  final double depth;
  final double roundness;

  const SpinningScallopIndicator({
    super.key,
    this.lobes = 8,
    this.depth = .12,
    this.roundness = 1.4,
  });

  @override
  State<SpinningScallopIndicator> createState() =>
      _SpinningScallopIndicatorState();
}

class _SpinningScallopIndicatorState extends State<SpinningScallopIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: ClipPath(
            clipper: M3EShapeClipper(
              M3EShape.scalloped,
              lobes: widget.lobes,
              depth: widget.depth,
              roundness: widget.roundness,
            ),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
