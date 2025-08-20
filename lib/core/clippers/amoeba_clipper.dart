import 'package:flutter/material.dart';
// Import math for potential use, though not strictly needed for this path

/// A CustomClipper that defines an amoeba-like shape.
///
/// The path is approximated using cubic Bezier curves to create a fluid,
/// organic shape. The control points are relative to the size of the
/// widget being clipped.
class AmoebaClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start at the top center of the clipping area
    path.moveTo(size.width * 0.5, 0);

    // First cubic curve: Top-right to bottom-right section
    // Control points are adjusted to create an organic bulge
    path.cubicTo(
      size.width * 0.8, // Control point 1 X (pulls curve right)
      size.height * 0.2, // Control point 1 Y (starts curve downwards)
      size.width * 0.9, // Control point 2 X (pulls curve further right)
      size.height * 0.6, // Control point 2 Y (pulls curve downwards)
      size.width * 0.5, // End point X (bottom-center)
      size.height * 0.9, // End point Y (near bottom)
    );

    // Second cubic curve: Bottom-left to top-left section
    // Control points are adjusted for the left organic bulge
    path.cubicTo(
      size.width * 0.2, // Control point 1 X (pulls curve left)
      size.height * 0.6, // Control point 1 Y (pulls curve upwards)
      size.width * 0.1, // Control point 2 X (pulls curve further left)
      size.height * 0.2, // Control point 2 Y (pulls curve upwards)
      size.width * 0.5, // End point X (back to top-center)
      0, // End point Y (back to top)
    );

    // Close the path to form a complete shape
    path.close();
    return path;
  }

  /// Determines whether the clipper needs to re-clip the widget.
  ///
  /// For a static shape like this amoeba, it typically doesn't need to re-clip
  /// unless the size of the widget changes or the shape itself needs to be
  /// dynamic based on some external factor.
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // Return false if the shape is static and doesn't change.
    // Return true if the shape depends on state that might change (e.g., animation values).
    return false;
  }
}
