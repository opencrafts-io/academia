import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class PostComposerSectionHeader extends StatelessWidget {
  final String title;
  final AssetGenImage? icon;

  const PostComposerSectionHeader({super.key, required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          icon!.image(width: 20, height: 20),
          const SizedBox(width: 8),
        ],
        Text(title, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
