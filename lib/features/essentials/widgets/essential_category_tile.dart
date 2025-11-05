import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EssentialCategoryTile extends StatelessWidget {
  const EssentialCategoryTile({
    required this.title,
    required this.iconWidget,
    this.onTap,
    required this.position,
    required this.crossAxisCount,
    required this.totalItems,
    super.key,
  });

  final String title;
  final Widget iconWidget;
  final VoidCallback? onTap;
  final int position;
  final int crossAxisCount;
  final int totalItems;

  static const Radius sharpRadius = Radius.circular(4.0);
  static const Radius roundedRadius = Radius.circular(16.0);
  BorderRadius _getBorderRadius() {
    // Calculate current row (0-indexed)
    final currentRow = position ~/ crossAxisCount;
    // Calculate total rows
    final totalRows = (totalItems / crossAxisCount).ceil();

    // Check if the tile is in the first row (Top)
    final isTopRow = currentRow == 0;
    // Check if the tile is in the last row (Bottom)
    final isBottomRow = currentRow == totalRows - 1;

    // Check if the tile is the first column element (Left)
    final isLeftColumn = position % crossAxisCount == 0;
    // Check if the tile is the last column element (Right)
    final isRightColumn = position % crossAxisCount == (crossAxisCount - 1);

    // Apply rounded or sharp corners based on position
    Radius topLeft = (isTopRow && isLeftColumn) ? roundedRadius : sharpRadius;
    Radius topRight = (isTopRow && isRightColumn) ? roundedRadius : sharpRadius;
    Radius bottomLeft = (isBottomRow && isLeftColumn)
        ? roundedRadius
        : sharpRadius;
    Radius bottomRight = (isBottomRow && isRightColumn)
        ? roundedRadius
        : sharpRadius;

    return BorderRadius.only(
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    final customBorderRadius = _getBorderRadius();
    return Card.filled(
      margin: const EdgeInsets.all(1),
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).colorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(borderRadius: customBorderRadius),
      child: InkWell(
        onTap:
            onTap ??
            () {
              showAdaptiveDialog(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                  title: Text("Feature coming soon"),
                  content: Text(
                    "The selected feature is not available at the moment. "
                    "Please try accessing it later",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text("Ok sure"),
                    ),
                  ],
                ),
              );
            },
        borderRadius: customBorderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              iconWidget,
            ],
          ),
        ),
      ),
    );
  }
}
