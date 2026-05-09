import 'package:flutter/material.dart';

class EventImageHelperTextWidget extends StatelessWidget {
  final String text;

  const EventImageHelperTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.bodySmall!.copyWith(color: Colors.grey[600]),
      ),
    );
  }
}
