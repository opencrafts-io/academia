import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A colorful, mood-tile-style card for the essentials "Explore tools" grid.
/// Each tile carries its own tonal color and a large, faded decorative icon
/// bleeding off one corner, with the title anchored in the opposite corner.
class EssentialCategoryTile extends StatelessWidget {
  const EssentialCategoryTile({
    required this.title,
    required this.iconPath,
    required this.color,
    required this.onColor,
    this.onTap,
    this.featured = false,
    super.key,
  });

  final String title;
  final String iconPath;
  final Color color;
  final Color onColor;
  final VoidCallback? onTap;

  /// Featured tiles get a larger title and a bigger decorative icon.
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final iconSize = featured ? 108.0 : 76.0;

    return Material(
      color: color,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap:
            onTap ??
            () {
              showAdaptiveDialog(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                  title: const Text("Feature coming soon"),
                  content: const Text(
                    "The selected feature is not available at the moment. "
                    "Please try accessing it later",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text("Ok sure"),
                    ),
                  ],
                ),
              );
            },
        child: Stack(
          children: [
            Positioned(
              right: -iconSize * 0.18,
              bottom: -iconSize * 0.18,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(iconPath, height: iconSize),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  title,
                  style:
                      (featured
                              ? Theme.of(context).textTheme.titleLarge
                              : Theme.of(context).textTheme.titleMedium)
                          ?.copyWith(
                            color: onColor,
                            fontWeight: FontWeight.bold,
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
