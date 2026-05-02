import 'package:flutter/material.dart';

class PostLikeButton extends StatelessWidget {
  final int upvotes;
  final bool isLiked;
  final VoidCallback onTap;

  final EdgeInsetsGeometry? padding;
  final double? iconSize;

  const PostLikeButton({
    super.key,
    required this.upvotes,
    required this.isLiked,
    required this.onTap,
    this.padding,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final color = isLiked
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.outline;

    final effectivePadding = padding ??
        const EdgeInsets.symmetric(horizontal: 14, vertical: 8);
    final effectiveIconSize = iconSize ?? 22;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: effectivePadding,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: color, width: .5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(isLiked),
                size: effectiveIconSize,
                color: color,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '$upvotes',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: color,
                fontWeight: isLiked ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
