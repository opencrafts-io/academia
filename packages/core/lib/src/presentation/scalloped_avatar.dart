import 'dart:math' as math;

import 'package:flutter/material.dart';

class ScallopedAvatar extends StatelessWidget {
  const ScallopedAvatar({
    super.key,
    required this.label,
    this.image,
    this.radius = 24,
    this.scallops = 10,
    this.depth = 3,
  });

  final String label;
  final ImageProvider<Object>? image;
  final double radius;
  final int scallops;
  final double depth;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final diameter = radius * 2;

    return Semantics(
      label: label,
      image: true,
      child: ExcludeSemantics(
        child: ClipPath(
          clipper: _ScallopClipper(scallops: scallops, depth: depth),
          child: SizedBox.square(
            dimension: diameter,
            child: DecoratedBox(
              decoration: BoxDecoration(color: colors.primaryContainer),
              child: image == null
                  ? _fallback(colors)
                  : Image(
                      image: image!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _fallback(colors),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fallback(ColorScheme colors) => Icon(
    Icons.person_rounded,
    size: radius * 1.15,
    color: colors.onPrimaryContainer,
  );
}

class _ScallopClipper extends CustomClipper<Path> {
  const _ScallopClipper({required this.scallops, required this.depth});

  final int scallops;
  final double depth;

  @override
  Path getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = math.min(size.width, size.height) / 2;
    final innerRadius = math.max(0, outerRadius - depth);
    final path = Path();
    final segment = math.pi / scallops;

    for (var index = 0; index < scallops * 2; index++) {
      final radius = index.isEven ? outerRadius : innerRadius;
      final angle = -math.pi / 2 + segment * index;
      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      if (index == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        final previousAngle = -math.pi / 2 + segment * (index - 1);
        final previousRadius = (index - 1).isEven ? outerRadius : innerRadius;
        final previous = Offset(
          center.dx + previousRadius * math.cos(previousAngle),
          center.dy + previousRadius * math.sin(previousAngle),
        );
        final midpoint = Offset(
          (previous.dx + point.dx) / 2,
          (previous.dy + point.dy) / 2,
        );
        path.quadraticBezierTo(
          previous.dx,
          previous.dy,
          midpoint.dx,
          midpoint.dy,
        );
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _ScallopClipper oldClipper) =>
      oldClipper.scallops != scallops || oldClipper.depth != depth;
}
