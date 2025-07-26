import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';
import '../../domain/domain.dart';

class EventAboutSection extends StatelessWidget {
  final Event event;
  const EventAboutSection({super.key, required this.event});

  @override
  Widget build(BuildContext context) {

    final TextStyle titleStyle = ResponsiveBreakPoints.isTablet(context) || ResponsiveBreakPoints.isDesktop(context)
        ? Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)
        : Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface);

    final TextStyle descriptionStyle = ResponsiveBreakPoints.isTablet(context) || ResponsiveBreakPoints.isDesktop(context)
        ? Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant, height: 1.5)
        : Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant, height: 1.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Event',
          style: titleStyle,
        ),
        const SizedBox(height: 12),
        Text(
          event.description,
          style: descriptionStyle,
        ),
      ],
    );
  }
}