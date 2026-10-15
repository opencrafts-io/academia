import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

Future<T?> showStudyToolsSheet<T>({
  required BuildContext context,
  required Widget child,
}) => showModalSheet<T>(
  context: context,
  swipeDismissible: true,
  transitionCurve: Curves.easeOutCubic,
  builder: (context) => Sheet(
    scrollConfiguration: const SheetScrollConfiguration(),
    decoration: const MaterialSheetDecoration(
      size: SheetSize.fit,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    ),
    physics: BouncingSheetPhysics(),
    child: SheetKeyboardDismissible(
      dismissBehavior: SheetKeyboardDismissBehavior.onDragDown(
        isContentScrollAware: true,
      ),
      child: child,
    ),
  ),
);
