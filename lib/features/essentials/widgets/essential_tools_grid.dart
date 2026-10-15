import 'package:flutter/material.dart';

typedef EssentialToolsGridItemBuilder = Widget Function(
  BuildContext context,
  int index,
  BorderRadius borderRadius,
);

class EssentialToolsGrid extends StatelessWidget {
  const EssentialToolsGrid({
    required this.itemCount,
    required this.itemBuilder,
    super.key,
  });

  final int itemCount;
  final EssentialToolsGridItemBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    const columnCount = 2;
    const cornerRadius = Radius.circular(8);
    final color = Theme.of(context).colorScheme.surfaceContainerHigh;
    final lastRow = (itemCount - 1) ~/ columnCount;

    Widget tile(int index) {
      final row = index ~/ columnCount;
      final column = index % columnCount;
      final radius = BorderRadius.only(
        topLeft: row == 0 && column == 0 ? cornerRadius : Radius.zero,
        topRight: row == 0 && column == columnCount - 1
            ? cornerRadius
            : Radius.zero,
        bottomLeft: row == lastRow && column == 0 ? cornerRadius : Radius.zero,
        bottomRight: row == lastRow && column == columnCount - 1
            ? cornerRadius
            : Radius.zero,
      );
      if (index >= itemCount) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              bottomRight: row == lastRow ? cornerRadius : Radius.zero,
            ),
          ),
        );
      }

      return itemBuilder(context, index, radius);
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount.isOdd ? itemCount + 1 : itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        mainAxisExtent: 64,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) => tile(index),
    );
  }
}
