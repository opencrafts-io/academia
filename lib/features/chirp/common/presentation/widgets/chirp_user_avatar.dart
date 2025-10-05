import 'package:academia/core/clippers/clippers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChirpUserAvatar extends StatelessWidget {
  const ChirpUserAvatar({
    super.key,
    this.radius = 18, // Radius of the base CircleAvatar
    this.scallopDepth = 4.0, // Depth of the scallops, passed to ScallopClipper
    this.numberOfScallops = 8, // Number of scallops, passed to ScallopClipper
    required this.avatarUrl,
  });

  final double radius;
  final double scallopDepth;
  final int numberOfScallops;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ScallopClipper(
        scallopDepth: scallopDepth,
        numberOfScallops: numberOfScallops,
      ),
      child: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(avatarUrl),
      ),
    );
  }
}
