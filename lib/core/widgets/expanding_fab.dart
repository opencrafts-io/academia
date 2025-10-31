import 'package:flutter/material.dart';
import 'dart:math' as math;

class FabAction {
  final IconData icon;
  final Color backgroundColor;
  final Color? iconColor;
  final VoidCallback onPressed;
  final String? tooltip;

  FabAction({
    required this.icon,
    required this.backgroundColor,
    this.iconColor,
    required this.onPressed,
    this.tooltip,
  });
}

class _ActionButton extends StatelessWidget {
  final FabAction action;
  final VoidCallback onPressed;

  const _ActionButton({required this.action, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: action.backgroundColor,
      onPressed: onPressed,
      tooltip: action.tooltip,
      child: Icon(
        action.icon,
        color: action.iconColor ?? Theme.of(context).colorScheme.onSecondary,
        size: 20,
      ),
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
      curve: Curves.elasticOut,
      reverseCurve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
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
    return Flow(
      delegate: _ExpandingFabFlowDelegate(animation: _expandAnimation),
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
          backgroundColor: widget.mainButtonColor,
          onPressed: _toggle,
          child: AnimatedRotation(
            turns: _isExpanded ? 0.125 : 0.0,
            duration: const Duration(milliseconds: 250),
            child: Icon(_isExpanded ? widget.closeIcon : widget.mainIcon),
          ),
        ),
      ],
    );
  }
}

class _ExpandingFabFlowDelegate extends FlowDelegate {
  final Animation<double> animation;

  // Pass the animation to the super constructor's `repaint` argument.
  // This tells Flow to repaint whenever the animation ticks.
  _ExpandingFabFlowDelegate({required this.animation})
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

    const distance = 80.0;

    for (int i = 0; i < context.childCount - 1; i++) {
      final smallButtonSize = context.getChildSize(i)!;
      final angle = (i * (math.pi / 4)) + (math.pi / 4);

      // Calculate the (x, y) offset from the main button's center
      final dx = -math.cos(angle) * distance;
      final dy = -math.sin(angle) * distance;

      // Apply the animation value to the offset
      final offset = Offset(dx, dy) * animationValue;

      // Calculate the final top-left (x, y) position for the small button
      final x = mainButtonCenter.dx + offset.dx - (smallButtonSize.width / 2);
      final y = mainButtonCenter.dy + offset.dy - (smallButtonSize.height / 2);

      // Use a Matrix4 to translate, then scale from the center
      final matrix = Matrix4.identity()
        // 1. Move to the final (x, y) position
        ..translate(x, y)
        // 2. Move to the center of the small button
        ..translate(smallButtonSize.width / 2, smallButtonSize.height / 2)
        // 3. Scale from that center
        ..scale(animationValue, animationValue)
        // 4. Move back
        ..translate(-smallButtonSize.width / 2, -smallButtonSize.height / 2);

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
