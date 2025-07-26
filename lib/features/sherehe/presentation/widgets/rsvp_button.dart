import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';

class RsvpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RsvpButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    final double buttonHeight = ResponsiveBreakPoints.isMobile(context) ? 50 : 56;

    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: FilledButton(
        onPressed: onPressed,
        child: const Text('I\'m Going'),
      ),
    );
  }
}