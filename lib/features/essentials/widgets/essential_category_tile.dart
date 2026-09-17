import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A compact, rounded card for an essentials tool in the "Explore tools" grid.
class EssentialCategoryTile extends StatelessWidget {
  const EssentialCategoryTile({
    required this.title,
    required this.iconPath,
    required this.color,
    required this.onColor,
    required this.borderRadius,
    this.onTap,
    super.key,
  });

  final String title;
  final String iconPath;
  final Color color;
  final Color onColor;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: borderRadius,
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
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 12, end: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: onColor, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 8),
              Image.asset(iconPath, width: 36, height: 36),
            ],
          ),
        ),
      ),
    );
  }
}
