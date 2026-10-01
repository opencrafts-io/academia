import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math' as math;

class FabAction {
  final IconData icon;
  final Color backgroundColor;
  final Color? iconColor;
  final VoidCallback onPressed;
  final String? tooltip;
  final String? label;

  FabAction({
    required this.icon,
    required this.backgroundColor,
    this.iconColor,
    required this.onPressed,
    this.tooltip,
    this.label,
  });
}

class _ActionButton extends StatelessWidget {
  final FabAction action;
  final VoidCallback onPressed;

  const _ActionButton({required this.action, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final button = FloatingActionButton.small(
      heroTag: action.hashCode,
      backgroundColor: action.backgroundColor,
      onPressed: onPressed,
      tooltip: action.tooltip,
      child: Icon(
        action.icon,
        color: action.iconColor ?? Theme.of(context).colorScheme.onSecondary,
        size: 20,
      ),
    );
    if (action.label == null) return button;

    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: colors.surfaceContainerHigh,
          elevation: 2,
          shadowColor: colors.shadow.withAlpha(40),
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            child: Text(
              action.label!,
              style: Theme.of(context).textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(width: 8),
        button,
      ],
    );
  }
}

class ExpandingFab extends StatefulWidget {
  final List<FabAction> actions;
  final Color? mainButtonColor;
  final IconData? mainIcon;
  final IconData? closeIcon;

  const ExpandingFab({
    super.key,
    required this.actions,
    this.mainButtonColor,
    this.mainIcon = Icons.add,
    this.closeIcon = Icons.close,
  });

  @override
  State<ExpandingFab> createState() => _ExpandingFabState();
}

class _ExpandingFabState extends State<ExpandingFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    HapticFeedback.selectionClick();
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    _controller.duration = reduceMotion
        ? Duration.zero
        : const Duration(milliseconds: 260);
    return Flow(
      delegate: _ExpandingFabFlowDelegate(
        animation: _expandAnimation,
        actions: widget.actions,
      ),
      clipBehavior: Clip.none,
      children: [
        ...widget.actions.map((action) {
          return IgnorePointer(
            ignoring: !_isExpanded,
            child: _ActionButton(
              action: action,
              onPressed: () {
                action.onPressed();
                _toggle();
              },
            ),
          );
        }),

        // Main FAB (Must be the LAST child)
        FloatingActionButton(
          heroTag: widget.hashCode,
          backgroundColor: widget.mainButtonColor,
          tooltip: _isExpanded ? 'Close create menu' : 'Add to agenda',
          onPressed: _toggle,
          child: AnimatedRotation(
            turns: _isExpanded ? 0.125 : 0.0,
            duration: reduceMotion
                ? Duration.zero
                : const Duration(milliseconds: 220),
            child: Icon(_isExpanded ? widget.closeIcon : widget.mainIcon),
          ),
        ),
      ],
    );
  }
}

class _ExpandingFabFlowDelegate extends FlowDelegate {
  final Animation<double> animation;
  final List<FabAction> actions;

  // Pass the animation to the super constructor's `repaint` argument.
  // This tells Flow to repaint whenever the animation ticks.
  _ExpandingFabFlowDelegate({required this.animation, required this.actions})
    : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    // The animation value (0.0 to 1.0)
    final animationValue = animation.value;

    // Get the size of the main button (the last child)
    final mainButtonSize = context.getChildSize(context.childCount - 1)!;

    // Position the main button at the bottom-right of the Flow's available space
    final mainButtonX = context.size.width - mainButtonSize.width;
    final mainButtonY = context.size.height - mainButtonSize.height;

    // Calculate the center of the main button, which is our animation origin
    final mainButtonCenter = Offset(
      mainButtonX + mainButtonSize.width / 2,
      mainButtonY + mainButtonSize.height / 2,
    );

    // Paint the main button (last child)
    context.paintChild(
      context.childCount - 1,
      transform: Matrix4.translationValues(mainButtonX, mainButtonY, 0),
    );

    for (int i = 0; i < context.childCount - 1; i++) {
      final smallButtonSize = context.getChildSize(i)!;
      final radialAngle = (200 + (i * 35)) * math.pi / 180;
      final offset =
          Offset(math.cos(radialAngle) * 112, math.sin(radialAngle) * 112) *
          animationValue;

      // Calculate the final top-left (x, y) position for the small button
      final anchorX = i < actions.length && actions[i].label != null
          ? smallButtonSize.width - 20
          : smallButtonSize.width / 2;
      final x = mainButtonCenter.dx + offset.dx - anchorX;
      final y = mainButtonCenter.dy + offset.dy - (smallButtonSize.height / 2);

      // Use a Matrix4 to translate, then scale from the center
      final matrix = Matrix4.identity()
        // 1. Move to the final (x, y) position
        ..translateByDouble(x, y, 0.0, 1.0)
        // 2. Move to the center of the small button
        ..translateByDouble(
          smallButtonSize.width / 2,
          smallButtonSize.height / 2,
          0.0,
          1.0,
        )
        // 3. Scale from that center
        ..scaleByDouble(animationValue, animationValue, 1.0, 1.0)
        // 4. Move back
        ..translateByDouble(
          -smallButtonSize.width / 2,
          -smallButtonSize.height / 2,
          0.0,
          1.0,
        );

      context.paintChild(
        i,
        transform: matrix,
        opacity: animationValue.clamp(0.0, 1.0),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ExpandingFabFlowDelegate oldDelegate) {
    // We don't need to check animation != oldDelegate.animation
    // because we passed it to `super(repaint: animation)`.
    // The delegate itself has no other properties that change.
    return false;
  }
}
