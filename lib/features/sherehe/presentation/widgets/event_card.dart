import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';

class CardSizing {
  final double titleFontSize;
  final double bodyFontSize;
  final double iconSize;
  final double avatarRadius;
  final double avatarTextSize;
  final double spacing;
  final double avatarRowHeight;

  const CardSizing({
    required this.titleFontSize,
    required this.bodyFontSize,
    required this.iconSize,
    required this.avatarRadius,
    required this.avatarTextSize,
    required this.spacing,
    required this.avatarRowHeight,
  });
}

//Sizing helper
CardSizing getCardSizing(BuildContext context) {
  if (ResponsiveBreakPoints.isMobile(context)) {
    return const CardSizing(
      titleFontSize: 14,
      bodyFontSize: 12,
      iconSize: 14,
      avatarRadius: 10,
      avatarTextSize: 9,
      spacing: 4,
      avatarRowHeight: 24,
    );
  } else if (ResponsiveBreakPoints.isTablet(context)) {
    return const CardSizing(
      titleFontSize: 16,
      bodyFontSize: 14,
      iconSize: 16,
      avatarRadius: 12,
      avatarTextSize: 10,
      spacing: 6,
      avatarRowHeight: 28,
    );
  } else {
    return const CardSizing(
      titleFontSize: 18,
      bodyFontSize: 15,
      iconSize: 18,
      avatarRadius: 14,
      avatarTextSize: 11,
      spacing: 8,
      avatarRowHeight: 32,
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  final List<String> attendees;
  final bool isAttendeesLoading;
  final VoidCallback? onTap;

  const EventCard({
    super.key,
    required this.event,
    required this.attendees,
    required this.isAttendeesLoading,
    this.onTap,
  });

  double _calculateAvatarRowWidth({
    required int avatarCount,
    required double avatarRadius,
    required double spacing,
  }) {
    if (avatarCount <= 1) return avatarRadius * 2;
    return (avatarRadius * 2) + (spacing * (avatarCount - 1));
  }

  @override
  Widget build(BuildContext context) {
    final sizing = getCardSizing(context);
    const maxAvatars = 4;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox.expand(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: event.eventBannerImage!,
                  width: double.infinity,
                  errorWidget: (context, child, error) {
                    return Container(
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.errorContainer,
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),

              // Details section - takes remaining space
              Expanded(
                flex: 2, // Takes 2/5 of the available height
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.eventName,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          // fontSize: sizing.titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: sizing.spacing),
                      // Location
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: sizing.iconSize,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.eventLocation,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontSize: sizing.bodyFontSize,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sizing.spacing),

                      // Date
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: sizing.iconSize,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            ShereheUtils.formatDate(event.eventDate),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontSize: sizing.bodyFontSize,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: sizing.spacing),

                      // Time
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: sizing.iconSize,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            ShereheUtils.formatTime(event.eventDate),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontSize: sizing.bodyFontSize,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),

                      if (event.eventGenre!.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: sizing.spacing),
                          child: Wrap(
                            spacing: 4.0,
                            runSpacing: 2.0,
                            children: event.eventGenre!.map((genre) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                  vertical: 2.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  genre,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontSize: sizing.bodyFontSize - 1,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSecondaryContainer,
                                      ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                      const Spacer(),
                      // Attendees section - always at the bottom
                      if (isAttendeesLoading)
                        Row(
                          children: [
                            SizedBox(
                              width: _calculateAvatarRowWidth(
                                avatarCount: maxAvatars,
                                avatarRadius: sizing.avatarRadius,
                                spacing: 16.0,
                              ),
                              height: sizing.avatarRowHeight,
                              child: Stack(
                                children: List.generate(maxAvatars, (index) {
                                  return Positioned(
                                    left: index * 16.0,
                                    child: CircleAvatar(
                                      radius: sizing.avatarRadius,
                                      backgroundColor: Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainer,
                                      child: SizedBox(
                                        width: sizing.avatarRadius * 2,
                                        height: sizing.avatarRadius * 2,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Theme.of(
                                                  context,
                                                ).colorScheme.outline,
                                              ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Loading attendees...",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        )
                      else if (attendees.isNotEmpty)
                        Row(
                          children: [
                            SizedBox(
                              width: _calculateAvatarRowWidth(
                                avatarCount: attendees.length >= maxAvatars
                                    ? maxAvatars
                                    : attendees.length,
                                avatarRadius: sizing.avatarRadius,
                                spacing: 16.0,
                              ),
                              height: sizing.avatarRowHeight,
                              child: Stack(
                                children: List.generate(
                                  attendees.length >= maxAvatars
                                      ? maxAvatars
                                      : attendees.length,
                                  (index) {
                                    final isOverflow =
                                        index == maxAvatars - 1 &&
                                        attendees.length == maxAvatars &&
                                        event.attendeeCount > maxAvatars;

                                    return Positioned(
                                      left: index * 16.0,
                                      child: CircleAvatar(
                                        radius: sizing.avatarRadius,
                                        backgroundColor: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        child: Text(
                                          isOverflow
                                              ? '+${event.attendeeCount - (maxAvatars - 1)}'
                                              : ShereheUtils.getInitials(
                                                  attendees[index],
                                                ),
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                            fontSize: sizing.avatarTextSize,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Builder(
                                builder: (context) {
                                  if (event.attendeeCount == 1) {
                                    return Text(
                                      "is attending",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    );
                                  } else if (event.attendeeCount <=
                                      maxAvatars - 1) {
                                    return Text(
                                      "are attending",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    );
                                  } else {
                                    final extra =
                                        event.attendeeCount - (maxAvatars - 1);
                                    return Text(
                                      "and $extra other${extra > 1 ? 's' : ''} are attending",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
