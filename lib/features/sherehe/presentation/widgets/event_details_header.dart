import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/domain.dart';
import '../../../../constants/constants.dart';

class EventDetailsHeader extends StatelessWidget {
  final Event event;

  const EventDetailsHeader({super.key, required this.event});

  double _getExpandedHeight(BuildContext context) {
    if (ResponsiveBreakPoints.isMobile(context)) {
      return 300.0;
    } else if (ResponsiveBreakPoints.isTablet(context)) {
      return 400.0;
    } else { // Desktop and Large Desktop
      return 500.0;
    }
  }

  @override
  Widget build(BuildContext context) {

    return SliverAppBar(
      expandedHeight: _getExpandedHeight(context),
      pinned: true,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // TODO: Implement bookmark functionality
          },
          icon: const Icon(Icons.bookmark_border),
        ),
        IconButton(
          onPressed: () {
            // TODO: Implement more options functionality
          },
          icon: const Icon(Icons.more_vert),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Use NetworkImage or AssetImage based on your data source
            // Example using AssetImage like in original:
            Image.asset(
              event.imageUrl.isNotEmpty ? event.imageUrl : 'assets/images/default_event.jpg',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: ResponsiveBreakPoints.isMobile(context) ? 16 : 32,
              right: ResponsiveBreakPoints.isMobile(context) ? 16 : 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: event.genre.map((genre) {
                      return Chip(
                        label: Text(
                          genre,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                            fontSize: ResponsiveBreakPoints.isMobile(context) ? 10 : 12,
                          ),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                        side: BorderSide.none,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith( // Use headlineMedium
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: ResponsiveBreakPoints.isMobile(context) ? 16 : 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        event.date,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith( // Use bodyMedium
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.location_on,
                        size: ResponsiveBreakPoints.isMobile(context) ? 16 : 20,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith( // Use bodyMedium
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}