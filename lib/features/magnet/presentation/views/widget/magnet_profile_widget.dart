import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MagnetProfileWidget extends StatelessWidget {
  final String? image;
  final double radius;

  const MagnetProfileWidget({
    super.key,
    this.image,
    this.radius = 20,
  });

  bool _isUrl(String value) {
    return value.startsWith('http://') || value.startsWith('https://');
  }

  bool _isBase64(String value) {
    return value.contains('base64,') ||
        (value.length > 100 && RegExp(r'^[A-Za-z0-9+/=]+$').hasMatch(value));
  }

  ImageProvider _resolveImage() {
    if (image == null || image!.isEmpty) {
      return const AssetImage('assets/images/default_avatar.png');
    } else if (_isUrl(image!)) {
      return CachedNetworkImageProvider(image!);
    } else if (_isBase64(image!)) {
      try {
        String base64String = image!;
        if (base64String.contains('base64,')) {
          base64String = base64String.split('base64,').last;
        }
        Uint8List bytes = base64Decode(base64String);
        return MemoryImage(bytes);
      } catch (_) {
        return const AssetImage('assets/images/default_avatar.png');
      }
    }
    return const AssetImage('assets/images/default_avatar.png');
  }

  @override
  Widget build(BuildContext context) {
    final provider = _resolveImage();

    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: Image(
          image: provider,
          fit: BoxFit.cover, // Ensures it fills perfectly
          width: radius * 2,
          height: radius * 2,
        ),
      ),
    );
  }
}
