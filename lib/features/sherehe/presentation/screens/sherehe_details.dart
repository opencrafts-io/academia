import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShereheDetails extends StatefulWidget {
  const ShereheDetails({super.key});

  @override
  State<ShereheDetails> createState() => _ShereheDetailsState();
}

class _ShereheDetailsState extends State<ShereheDetails> {
  int normalTicketCount = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero image with app bar
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(
                Icons.arrow_back,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {}, //TODO: Add functionality for favourites
                icon: Icon(
                  Icons.bookmark_border,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              IconButton(
                onPressed: () {}, //TODO : Add Overlay or smth for the more details page
                icon: Icon(
                  Icons.more_vert,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/gaelle-marcel-vrkSVpOwchk-unsplash.jpg',
                    fit: BoxFit.cover,
                  ),
                  // Gradient overlay for better text readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  // Event title and details overlay
                  Positioned(
                    bottom: 80,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category chips
                        Row(
                          children: [
                            Chip(
                              label: Text(
                                'Music',
                                style: TextStyle(
                                  color: theme.colorScheme.onSecondaryContainer,
                                  fontSize: 12,
                                ),
                              ),
                              backgroundColor: theme.colorScheme.secondaryContainer,
                              side: BorderSide.none,
                            ),
                            const SizedBox(width: 8),
                            Chip(
                              label: Text(
                                'Party',
                                style: TextStyle(
                                  color: theme.colorScheme.onSecondaryContainer,
                                  fontSize: 12,
                                ),
                              ),
                              backgroundColor: theme.colorScheme.secondaryContainer,
                              side: BorderSide.none,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Event title
                        Text(
                          'Gender Reveal Party',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Date and location
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: theme.colorScheme.onPrimary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Sat, Jul 20',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: theme.colorScheme.onPrimary,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'Kryptons Apartments, Athi River',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onPrimary,
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
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // About Event section
                  Text(
                    'About Event',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Gender Reveal Party is an exciting celebration that brings together friends and family for an unforgettable moment of joy and anticipation as we discover the gender of our little bundle of joy.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Available Tickets section
                  Text(
                    'Available Tickets',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // First Pre-Sale ticket (Sold Out)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.outline.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.confirmation_num_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Early Bird Tickets',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Ksh80.00',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'Sold Out',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onErrorContainer,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Second Pre-Sale ticket (Available)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.outline.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.confirmation_num_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'FOMO tickets',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Ksh100.00',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.remove,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            Text(
                              '3',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Normal ticket (Available)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.outline.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.confirmation_num_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'VVIP Tickets',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Ksh120.00',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: normalTicketCount > 0
                                  ? () {
                                setState(() {
                                  normalTicketCount--;
                                });
                              }
                                  : null,
                              icon: Icon(
                                Icons.remove,
                                color: normalTicketCount > 0
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.outline,
                              ),
                            ),
                            Text(
                              '$normalTicketCount',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  normalTicketCount++;
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Buy Tickets button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: () {
                        // TODO: Handle ticket purchase pages and all
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        'Buy Tickets',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}