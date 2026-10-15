import 'package:flutter/material.dart';

import 'm3e_shape_clipper.dart';

class ScallopedAvatar extends StatelessWidget {
  const ScallopedAvatar({
    super.key,
    required this.label,
    this.image,
    this.radius = 24,
    this.scallops = 10,
    this.depth = 3,
    this.roundness = 1.4,
  });

  final String label;
  final ImageProvider<Object>? image;
  final double radius;
  final int scallops;
  final double depth;
  final double roundness;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final diameter = radius * 2;

    return Semantics(
      label: label,
      image: true,
      child: ExcludeSemantics(
        child: ClipPath(
          clipper: M3EShapeClipper(
            M3EShape.scalloped,
            lobes: scallops,
            depth: radius == 0 ? .12 : depth / radius,
            roundness: roundness,
          ),
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
