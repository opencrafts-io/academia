import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart' as core;
import 'package:flutter/material.dart';

class ChirpUserAvatar extends StatelessWidget {
  const ChirpUserAvatar({
    super.key,
    this.radius = 18, // Radius of the base CircleAvatar
    required this.avatarUrl,
  });

  final double radius;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const core.M3EShapeClipper(core.M3EShape.arch),
      child: SizedBox.square(
        dimension: radius * 2,
        child: Image(
          image: CachedNetworkImageProvider(avatarUrl),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            final colors = Theme.of(context).colorScheme;
            return ColoredBox(
              color: colors.primaryContainer,
              child: Icon(
                Icons.person_rounded,
                color: colors.onPrimaryContainer,
              ),
            );
          },
        ),
      ),
    );
  }
}
