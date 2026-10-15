import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/rendering.dart';

/// The Material 3 Expressive shape family available to [M3EShapeClipper].
enum M3EShape {
  circle,
  square,
  slanted,
  arch,
  semicircle,
  oval,
  pill,
  triangle,
  arrow,
  fan,
  diamond,
  clamshell,
  pentagon,
  gem,
  verySunny,
  sunny,
  cookie4Sided,
  cookie6Sided,
  cookie7Sided,
  cookie9Sided,
  cookie12Sided,
  clover4Leaf,
  clover8Leaf,
  burst,
  softBurst,
  boom,
  softBoom,
  flower,
  scalloped,
  puffy,
  puffyDiamond,
  ghostish,
  pixelCircle,
  pixelTriangle,
  bun,
  heart,
}

/// Clips a child to a Material 3 Expressive shape.
///
/// The path is kept within a centered square, so non-square children retain
/// the shape's proportions. Reuse this clipper anywhere a shape from the M3E
/// family is needed:
///
/// ```dart
/// ClipPath(
///   clipper: const M3EShapeClipper(M3EShape.flower),
///   child: avatar,
/// )
/// ```
class M3EShapeClipper extends CustomClipper<Path> {
  const M3EShapeClipper(
    this.shape, {
    this.rotation = 0,
    this.lobes = 8,
    this.depth = .12,
    this.roundness = 1.4,
    this.cornerRadius = .18,
  });

  final M3EShape shape;
  final double rotation;

  /// Number of rounded points around [M3EShape.scalloped].
  final int lobes;

  /// Scallop depth as a fraction of the shape radius. Defaults to 12%.
  final double depth;

  /// Curve profile for [M3EShape.scalloped]. Values above 1 make fuller lobes.
  final double roundness;

  /// Corner radius as a fraction of the 100-unit shape canvas. Defaults to 18%.
  /// Used by the arch base and rounded polygon shapes.
  final double cornerRadius;

  @override
  Path getClip(Size size) {
    final path = _shapePath(
      shape,
      lobes: lobes,
      depth: depth,
      roundness: roundness,
      cornerRadius: cornerRadius,
    );
    final scale = math.min(size.width, size.height) / 100;
    final dx = (size.width - 100 * scale) / 2;
    final dy = (size.height - 100 * scale) / 2;
    final scaledPath = path.transform(
      Float64List.fromList([
        scale,
        0,
        0,
        0,
        0,
        scale,
        0,
        0,
        0,
        0,
        1,
        0,
        dx,
        dy,
        0,
        1,
      ]),
    );
    if (rotation == 0) return scaledPath;

    final cosine = math.cos(rotation);
    final sine = math.sin(rotation);
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    return scaledPath.transform(
      Float64List.fromList([
        cosine,
        sine,
        0,
        0,
        -sine,
        cosine,
        0,
        0,
        0,
        0,
        1,
        0,
        centerX - cosine * centerX + sine * centerY,
        centerY - sine * centerX - cosine * centerY,
        0,
        1,
      ]),
    );
  }

  @override
  bool shouldReclip(covariant M3EShapeClipper oldClipper) =>
      oldClipper.shape != shape ||
      oldClipper.rotation != rotation ||
      oldClipper.lobes != lobes ||
      oldClipper.depth != depth ||
      oldClipper.roundness != roundness ||
      oldClipper.cornerRadius != cornerRadius;
}

Path _shapePath(
  M3EShape shape, {
  required int lobes,
  required double depth,
  required double roundness,
  required double cornerRadius,
}) {
  const bounds = Rect.fromLTWH(2, 2, 96, 96);
  switch (shape) {
    case M3EShape.circle:
      return Path()..addOval(bounds);
    case M3EShape.square:
      return Path()
        ..addRRect(RRect.fromRectAndRadius(bounds, const Radius.circular(22)));
    case M3EShape.slanted:
      return _smoothPolygon(const [
        Offset(26, 4),
        Offset(96, 4),
        Offset(88, 96),
        Offset(4, 96),
      ]);
    case M3EShape.arch:
      final radius = cornerRadius.clamp(0, .24).toDouble() * 100;
      return Path()
        ..moveTo(5, 98 - radius)
        ..lineTo(5, 50)
        ..cubicTo(5, 24, 25, 4, 50, 4)
        ..cubicTo(75, 4, 95, 24, 95, 50)
        ..lineTo(95, 98 - radius)
        ..quadraticBezierTo(95, 98, 95 - radius, 98)
        ..lineTo(5 + radius, 98)
        ..quadraticBezierTo(5, 98, 5, 98 - radius)
        ..close();
    case M3EShape.semicircle:
      return Path()
        ..moveTo(2, 98)
        ..arcToPoint(
          const Offset(98, 98),
          radius: const Radius.circular(48),
          clockwise: false,
        )
        ..close();
    case M3EShape.oval:
      return Path()..addOval(const Rect.fromLTWH(8, 2, 84, 96));
    case M3EShape.pill:
      return Path()
        ..addRRect(RRect.fromRectAndRadius(bounds, const Radius.circular(48)));
    case M3EShape.triangle:
      return _smoothPolygon(const [
        Offset(50, 2),
        Offset(98, 96),
        Offset(2, 96),
      ]);
    case M3EShape.arrow:
      return _radialShape(
        lobes: 3,
        depth: .18,
        power: 1.4,
        rotation: -math.pi / 2,
      );
    case M3EShape.fan:
      return Path()
        ..moveTo(4, 6)
        ..arcToPoint(
          const Offset(96, 98),
          radius: const Radius.circular(92),
          clockwise: false,
        )
        ..lineTo(4, 98)
        ..close();
    case M3EShape.diamond:
      return _smoothPolygon(const [
        Offset(50, 2),
        Offset(98, 50),
        Offset(50, 98),
        Offset(2, 50),
      ]);
    case M3EShape.clamshell:
      return _smoothPolygon(const [
        Offset(27, 7),
        Offset(73, 7),
        Offset(97, 50),
        Offset(73, 93),
        Offset(27, 93),
        Offset(3, 50),
      ]);
    case M3EShape.pentagon:
      return _roundedPolygon(
        const [
          Offset(50, 2),
          Offset(96, 36),
          Offset(78, 96),
          Offset(22, 96),
          Offset(4, 36),
        ],
        radius: cornerRadius.clamp(0, .24).toDouble() * 100,
      );
    case M3EShape.gem:
      return _radialShape(lobes: 6, depth: .16, rotation: -math.pi / 2);
    case M3EShape.verySunny:
      return _radialShape(lobes: 8, depth: .2, power: 1.5);
    case M3EShape.sunny:
      return _starShape(points: 8, innerRadius: .72);
    case M3EShape.cookie4Sided:
      return _radialShape(lobes: 4, depth: .12, power: 1.1);
    case M3EShape.cookie6Sided:
      return _radialShape(lobes: 6, depth: .11, power: 1.1);
    case M3EShape.cookie7Sided:
      return _radialShape(lobes: 7, depth: .1, power: 1.1);
    case M3EShape.cookie9Sided:
      return _radialShape(lobes: 9, depth: .09, power: 1.1);
    case M3EShape.cookie12Sided:
      return _radialShape(lobes: 12, depth: .075, power: 1.1);
    case M3EShape.clover4Leaf:
      return _radialShape(lobes: 4, depth: .25, power: 2.1);
    case M3EShape.clover8Leaf:
      return _radialShape(lobes: 8, depth: .23, power: 2.1);
    case M3EShape.burst:
      return _starShape(points: 12, innerRadius: .55);
    case M3EShape.softBurst:
      return _radialShape(lobes: 10, depth: .24, power: .7);
    case M3EShape.boom:
      return _starShape(points: 16, innerRadius: .48);
    case M3EShape.softBoom:
      return _radialShape(lobes: 16, depth: .28, power: .8);
    case M3EShape.flower:
      return _radialShape(
        lobes: 6,
        depth: .23,
        power: 2.2,
        rotation: -math.pi / 2,
      );
    case M3EShape.scalloped:
      return _radialShape(
        lobes: lobes.clamp(3, 32).toInt(),
        depth: depth.clamp(0, .45).toDouble(),
        power: roundness.clamp(.35, 4).toDouble(),
      );
    case M3EShape.puffy:
      return _radialShape(lobes: 8, depth: .14, power: 2.4);
    case M3EShape.puffyDiamond:
      return _radialShape(
        lobes: 4,
        depth: .14,
        power: 2.4,
        rotation: math.pi / 4,
      );
    case M3EShape.ghostish:
      return _smoothPolygon(const [
        Offset(7, 98),
        Offset(7, 43),
        Offset(18, 15),
        Offset(50, 3),
        Offset(82, 15),
        Offset(93, 43),
        Offset(93, 98),
        Offset(73, 90),
        Offset(50, 98),
        Offset(27, 90),
      ]);
    case M3EShape.pixelCircle:
      return _pixelCircle();
    case M3EShape.pixelTriangle:
      return _pixelTriangle();
    case M3EShape.bun:
      // The lobes overlap so the clipped image stays continuous through the
      // center instead of exposing the background between two separate paths.
      return Path()
        ..addRRect(
          RRect.fromRectAndRadius(
            const Rect.fromLTWH(8, 7, 84, 47),
            const Radius.circular(21),
          ),
        )
        ..addRRect(
          RRect.fromRectAndRadius(
            const Rect.fromLTWH(8, 46, 84, 47),
            const Radius.circular(21),
          ),
        );
    case M3EShape.heart:
      return _smoothPolygon(const [
        Offset(50, 96),
        Offset(8, 54),
        Offset(5, 35),
        Offset(15, 14),
        Offset(34, 8),
        Offset(50, 28),
        Offset(66, 8),
        Offset(85, 14),
        Offset(95, 35),
        Offset(92, 54),
      ]);
  }
}

Path _radialShape({
  required int lobes,
  required double depth,
  double power = 1,
  double rotation = 0,
}) {
  final points = <Offset>[];
  const steps = 144;
  for (var index = 0; index < steps; index++) {
    final angle = 2 * math.pi * index / steps + rotation;
    final wave = (1 + math.cos(lobes * angle)) / 2;
    final radius = 48 * (1 - depth * math.pow(1 - wave, power));
    points.add(
      Offset(50 + radius * math.cos(angle), 50 + radius * math.sin(angle)),
    );
  }
  return _smoothLoop(points);
}

Path _starShape({required int points, required double innerRadius}) {
  final vertices = <Offset>[];
  for (var index = 0; index < points * 2; index++) {
    final angle = -math.pi / 2 + math.pi * index / points;
    final radius = index.isEven ? 48.0 : 48 * innerRadius;
    vertices.add(
      Offset(50 + radius * math.cos(angle), 50 + radius * math.sin(angle)),
    );
  }
  return Path()..addPolygon(vertices, true);
}

Path _smoothPolygon(List<Offset> points) => _smoothLoop(points);

Path _roundedPolygon(List<Offset> points, {required double radius}) {
  if (points.length < 3 || radius <= 0) {
    return Path()..addPolygon(points, true);
  }

  Offset toward(Offset point, Offset target) {
    final dx = target.dx - point.dx;
    final dy = target.dy - point.dy;
    final length = math.sqrt(dx * dx + dy * dy);
    final inset = math.min(radius, length / 2);
    return Offset(
      point.dx + dx / length * inset,
      point.dy + dy / length * inset,
    );
  }

  final path = Path();
  for (var index = 0; index < points.length; index++) {
    final previous = points[(index - 1 + points.length) % points.length];
    final current = points[index];
    final next = points[(index + 1) % points.length];
    final beforeCorner = toward(current, previous);
    final afterCorner = toward(current, next);

    if (index == 0) {
      path.moveTo(beforeCorner.dx, beforeCorner.dy);
    } else {
      path.lineTo(beforeCorner.dx, beforeCorner.dy);
    }
    path.quadraticBezierTo(
      current.dx,
      current.dy,
      afterCorner.dx,
      afterCorner.dy,
    );
  }
  return path..close();
}

Path _smoothLoop(List<Offset> points) {
  final path = Path();
  if (points.isEmpty) return path;
  Offset midpoint(Offset a, Offset b) =>
      Offset((a.dx + b.dx) / 2, (a.dy + b.dy) / 2);
  path.moveTo(
    midpoint(points.last, points.first).dx,
    midpoint(points.last, points.first).dy,
  );
  for (var index = 0; index < points.length; index++) {
    final current = points[index];
    final next = points[(index + 1) % points.length];
    final end = midpoint(current, next);
    path.quadraticBezierTo(current.dx, current.dy, end.dx, end.dy);
  }
  return path..close();
}

Path _pixelCircle() {
  final vertices = <Offset>[];
  const steps = 48;
  for (var index = 0; index < steps; index++) {
    final angle = 2 * math.pi * index / steps;
    final x = 50 + 46 * math.cos(angle);
    final y = 50 + 46 * math.sin(angle);
    vertices.add(Offset((x / 8).round() * 8, (y / 8).round() * 8));
  }
  return Path()..addPolygon(vertices, true);
}

Path _pixelTriangle() {
  final path = Path()..moveTo(20, 4);
  for (var y = 4; y <= 96; y += 8) {
    path.lineTo(20 + (y - 4) * .72, y.toDouble());
  }
  path
    ..lineTo(20, 96)
    ..close();
  return path;
}
