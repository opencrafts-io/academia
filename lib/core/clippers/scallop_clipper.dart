import 'package:academia/features/profile/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'dart:math' as math; // Import for math functions like sin, cos

// Custom clipper to create a scalloped shape for a circular avatar
class ScallopClipper extends CustomClipper<Path> {
  final double
  scallopDepth; // Controls how deep the scallops are (e.g., 0 for a perfect circle)
  final int
  numberOfScallops; // How many distinct scallops there are around the circle

  // Constructor for ScallopClipper with customizable parameters
  ScallopClipper({this.scallopDepth = 8.0, this.numberOfScallops = 16});

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    // The base radius is half of the smallest dimension of the widget being clipped (e.g., the CircleAvatar)
    final baseRadius = math.min(size.width, size.height) / 2;

    // Calculate the outer and inner radii for the scallops
    // The outer radius is the base radius of the avatar.
    // The inner radius is where the valleys of the scallops will reach.
    // Ensure scallopDepth does not cause innerRadius to be too small or negative.
    final effectiveScallopDepth = math.min(
      scallopDepth,
      baseRadius * 0.9,
    ); // Limit depth to prevent issues
    final outerRadius = baseRadius;
    final innerRadius = baseRadius - effectiveScallopDepth;

    // Each full scallop (from one peak, through a valley, to the next peak) consists of two segments.
    // So, we divide 2*pi by (numberOfScallops * 2) to get the angle for half a scallop.
    final double angleSegment = (2 * math.pi) / (numberOfScallops * 2);

    // Start the path at the first peak (on the outer circle at angle 0)
    final initialPeakPoint = Offset(
      center.dx + outerRadius * math.cos(0),
      center.dy + outerRadius * math.sin(0),
    );
    path.moveTo(initialPeakPoint.dx, initialPeakPoint.dy);

    for (int i = 0; i < numberOfScallops; i++) {
      // Calculate angles for the current scallop's points:
      // The starting peak of the current scallop is implicitly the end of the previous one.
      final double currentPeakAngle = (2 * i) * angleSegment;
      final double valleyAngle =
          (2 * i + 1) * angleSegment; // Angle for the valley point
      final double nextPeakAngle =
          (2 * i + 2) * angleSegment; // Angle for the next peak point

      // Define the valley point (on the inner radius)
      final valleyPoint = Offset(
        center.dx + innerRadius * math.cos(valleyAngle),
        center.dy + innerRadius * math.sin(valleyAngle),
      );

      // Define the next peak point (on the outer radius)
      final nextPeakPoint = Offset(
        center.dx + outerRadius * math.cos(nextPeakAngle),
        center.dy + outerRadius * math.sin(nextPeakAngle),
      );

      // Calculate control points for the two quadratic bezier curves that form one scallop:
      // Control point for the first half (from current peak to valley):
      // Placed on the outer radius at an angle between the current peak and the valley.
      final double controlPoint1Angle = currentPeakAngle + (angleSegment * 0.5);
      final controlPoint1 = Offset(
        center.dx + outerRadius * math.cos(controlPoint1Angle),
        center.dy + outerRadius * math.sin(controlPoint1Angle),
      );

      // Control point for the second half (from valley to next peak):
      // Placed on the outer radius at an angle between the valley and the next peak.
      final double controlPoint2Angle = valleyAngle + (angleSegment * 0.5);
      final controlPoint2 = Offset(
        center.dx + outerRadius * math.cos(controlPoint2Angle),
        center.dy + outerRadius * math.sin(controlPoint2Angle),
      );

      // Draw the first quadratic bezier curve: from the current position (previous peak) to the `valleyPoint`
      // The `controlPoint1` guides the curve smoothly inwards.
      path.quadraticBezierTo(
        controlPoint1.dx,
        controlPoint1.dy, // Control point for the inward curve
        valleyPoint.dx,
        valleyPoint.dy, // End point (the valley)
      );

      // Draw the second quadratic bezier curve: from the `valleyPoint` to the `nextPeakPoint`
      // The `controlPoint2` guides the curve smoothly outwards.
      path.quadraticBezierTo(
        controlPoint2.dx,
        controlPoint2.dy, // Control point for the outward curve
        nextPeakPoint.dx,
        nextPeakPoint.dy, // End point (the next peak)
      );
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant ScallopClipper oldClipper) {
    // Reclip if the scallopDepth or numberOfScallops changes
    return oldClipper.scallopDepth != scallopDepth ||
        oldClipper.numberOfScallops != numberOfScallops;
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.radius = 18, // Radius of the base CircleAvatar
    this.scallopDepth = 4.0, // Depth of the scallops, passed to ScallopClipper
    this.numberOfScallops = 8, // Number of scallops, passed to ScallopClipper
  });

  final double radius;
  final double scallopDepth;
  final int numberOfScallops;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        // The ClipPath will automatically get the size of the CircleAvatar,
        // which is `radius * 2`. This size is then passed to the `getClip` method.
        final Widget avatarContent;

        if (state is ProfileLoadedState && state.profile.avatarUrl != null) {
          avatarContent = CircleAvatar(
            radius: radius,
            backgroundImage: CachedNetworkImageProvider(
              state.profile.avatarUrl!,
            ),
          );
        } else {
          avatarContent = CircleAvatar(
            radius: radius,
            backgroundColor: Colors.grey, // Default color when no avatar
            child: Icon(
              Symbols.person_4,
              size: radius * 1.2, // Adjust icon size relative to avatar radius
              color: Colors.white70, // Adjust icon color for visibility
            ),
          );
        }

        return ClipPath(
          clipper: ScallopClipper(
            scallopDepth: scallopDepth,
            numberOfScallops: numberOfScallops,
          ),
          child: avatarContent,
        );
      },
    );
  }
}
