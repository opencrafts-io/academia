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
  final String imagePath;
  final String title;
  final String location;
  final String time;
  final String date;
  final List<String> genres;
  final List<String> attendees;
  final int attendeesCount;
  final VoidCallback? onTap;

  const EventCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.location,
    required this.time,
    required this.date,
    required this.genres,
    this.attendees = const [],
    this.attendeesCount = 0,
    this.onTap,
  });

  String _getInitials(String name) {
    List<String> names = name.trim().split(' ');
    if (names.length == 1) return names.first[0].toUpperCase();
    return names.first[0].toUpperCase() + names.last[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final sizing = getCardSizing(context);
    const maxAvatars = 4;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox.expand(
        // Force the card to fill all available space
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Flexible image that takes up appropriate space
              Expanded(
                flex: 3, // Takes 3/5 of the available height
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  //to look at
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      color: Colors.grey[300],
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
                        title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: sizing.titleFontSize,
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
                              location,
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
                            date,
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
                            time,
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

                      if (genres.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: sizing.spacing),
                          child: Wrap(
                            spacing: 6.0,
                            runSpacing: 4.0,
                            children: genres.map((genre) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
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
                      if (attendees.isNotEmpty)
                        Row(
                          children: [
                            SizedBox(
                              width: maxAvatars * 20.0,
                              height: sizing.avatarRowHeight,
                              child: Stack(
                                children: List.generate(maxAvatars, (index) {
                                  // Show initials for first (maxAvatars - 1)
                                  if (index < maxAvatars - 1 &&
                                      index < attendees.length) {
                                    return Positioned(
                                      left: index * 16.0,
                                      child: CircleAvatar(
                                        radius: sizing.avatarRadius,
                                        backgroundColor: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        child: Text(
                                          _getInitials(attendees[index]),
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                            fontSize: sizing.avatarTextSize,
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  // Last avatar is for overflow (+X)
                                  if (index == maxAvatars - 1 &&
                                      attendeesCount > maxAvatars) {
                                    return Positioned(
                                      left: index * 16.0,
                                      child: CircleAvatar(
                                        radius: sizing.avatarRadius,
                                        backgroundColor: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        child: Text(
                                          '+${attendeesCount - (maxAvatars - 1)}',
                                          style: TextStyle(
                                            fontSize: sizing.avatarTextSize,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  // Fallback: show more initials if not overflowing
                                  final realIndex = index;
                                  if (realIndex < attendees.length) {
                                    return Positioned(
                                      left: index * 16.0,
                                      child: CircleAvatar(
                                        radius: sizing.avatarRadius,
                                        backgroundColor: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        child: Text(
                                          _getInitials(attendees[realIndex]),
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                            fontSize: sizing.avatarTextSize,
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  return const SizedBox.shrink();
                                }),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                " and ${attendeesCount - (maxAvatars - 1)} others are attending",
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
