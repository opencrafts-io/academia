import 'package:flutter/material.dart';
import './scallop_clipper.dart';
import 'dart:math' as math;

class SpinningScallopIndicator extends StatefulWidget {
  final double scallopDepth;
  final int numberOfScallops;

  const SpinningScallopIndicator({
    super.key,
    this.scallopDepth = 4.0, // Sane default
    this.numberOfScallops = 16, // Sane default
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
      duration: const Duration(seconds:2), // Adjust rotation speed here
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
            clipper: ScallopClipper(
              scallopDepth: widget.scallopDepth,
              numberOfScallops: widget.numberOfScallops,
            ),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                // The ScallopClipper handles the shape, so we use a simple Container
              ),
            ),
          ),
        );
      },
    );
  }
}
