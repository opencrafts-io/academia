import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Shimmering placeholder shown while comments are loading, shaped like
/// [CommentContentWidget] (avatar, username/timestamp row, content lines)
/// rather than a generic spinner, so the layout doesn't jump once real
/// comments arrive.
class CommentSkeletonLoader extends StatelessWidget {
  const CommentSkeletonLoader({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: List.generate(
          itemCount,
          (index) => _CommentPlaceholderTile(longContent: index.isEven),
        ),
      ),
    );
  }
}

class _CommentPlaceholderTile extends StatelessWidget {
  const _CommentPlaceholderTile({required this.longContent});

  final bool longContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              CircleAvatar(radius: 12),
              SizedBox(width: 8),
              Text('Username'),
              SizedBox(width: 6),
              Text('2h ago'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            longContent
                ? 'A placeholder line of comment content long enough to '
                      'wrap to a second line.'
                : 'A short placeholder comment.',
          ),
        ],
      ),
    );
  }
}
