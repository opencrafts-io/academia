import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../domain/domain.dart';
import '../../../../constants/constants.dart';

class EventDetailsHeader extends StatelessWidget {
  final Event event;

  const EventDetailsHeader({super.key, required this.event});

  double _getExpandedHeight(BuildContext context) {
    if (ResponsiveBreakPoints.isMobile(context)) {
      return MediaQuery.of(context).size.height * 0.40;
    } else if (ResponsiveBreakPoints.isTablet(context)) {
      return MediaQuery.of(context).size.height * 0.4;
    } else {
      return 500.0;
    }
  }
  String _formatDate(String isoString, {String pattern = 'dd MMM yyyy'}) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat(pattern).format(dateTime);
    } catch (e) {
      return isoString;
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
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: event.imageUrl,
              fit: BoxFit.cover,
              errorWidget: (context, child, error) {
                return Container(
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: const Icon(Icons.image_not_supported),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black],
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
                    spacing: 5.0,
                    runSpacing: 0.0,
                    children: event.genre.map((genre) {
                      return Chip(
                        label: Text(genre),
                        padding: EdgeInsets.all(0),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    event.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      // Use headlineMedium
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
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(event.date),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.share_arrival_time,
                        size: ResponsiveBreakPoints.isMobile(context) ? 16 : 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        event.time,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.location_on,
                        size: ResponsiveBreakPoints.isMobile(context) ? 16 : 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary,
                              ),
                          overflow: TextOverflow.visible,
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

