import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShereheDetails extends StatefulWidget {
  const ShereheDetails({super.key});

  @override
  State<ShereheDetails> createState() => _ShereheDetailsState();
}

class _ShereheDetailsState extends State<ShereheDetails> {
  void _showRSVPConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('🎉'),
          content: const Text(
            'Yay, see you there!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Awesome!'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAttendeeCard({
    required String initials,
    required String name,
    required String status,
    required Color avatarColor,
    required Color onAvatarColor,
    Widget? trailing,
    bool isHost = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: avatarColor,
            child: Text(
              initials,
              style: TextStyle(
                color: onAvatarColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  status,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isLargeTablet = screenWidth > 900;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero image with app bar
          SliverAppBar(
            expandedHeight: isTablet ? 500.0 : 400.0,
            pinned: true,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {}, //TODO: Add functionality for favourites
                icon: Icon(
                  Icons.bookmark_border,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              IconButton(
                onPressed: () {}, //TODO : Add Overlay or smth for the more details page
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).colorScheme.onPrimary,
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
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                  // Event title and details overlay
                  Positioned(
                    bottom: 20,
                    left: isTablet ? 32 : 16,
                    right: isTablet ? 32 : 16,
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
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                  fontSize: isTablet ? 14 : 12,
                                ),
                              ),
                              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                              side: BorderSide.none,
                            ),
                            const SizedBox(width: 8),
                            Chip(
                              label: Text(
                                'Party',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                  fontSize: isTablet ? 14 : 12,
                                ),
                              ),
                              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                              side: BorderSide.none,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Event title
                        Text(
                          'Gender Reveal Party',
                          style: isTablet
                              ? Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          )
                              : Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Date and location
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: isTablet ? 20 : 16,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Sat, Jul 20',
                              style: (isTablet
                                  ? Theme.of(context).textTheme.bodyLarge
                                  : Theme.of(context).textTheme.bodyMedium)?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.location_on,
                              size: isTablet ? 20 : 16,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'Kryptons Apartments, Athi River',
                                style: (isTablet
                                    ? Theme.of(context).textTheme.bodyLarge
                                    : Theme.of(context).textTheme.bodyMedium)?.copyWith(
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
          ),
          // Content
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isLargeTablet ? 1200 : double.infinity,
                ),
                child: Padding(
                  padding: EdgeInsets.all(isTablet ? 32.0 : 16.0),
                  child: isTablet && !isLargeTablet
                      ? _buildTabletLayout()
                      : isLargeTablet
                      ? _buildLargeTabletLayout()
                      : _buildPhoneLayout(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Phone layout (single column)
  Widget _buildPhoneLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAboutSection(),
        const SizedBox(height: 24),
        _buildWhoIsComingSection(),
        const SizedBox(height: 32),
        _buildRSVPButton(),
        const SizedBox(height: 20),
      ],
    );
  }

  // Tablet layout (optimized for medium screens)
  Widget _buildTabletLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column - About section
            Expanded(
              flex: 1,
              child: _buildAboutSection(),
            ),
            const SizedBox(width: 32),
            // Right column - Who's coming section
            Expanded(
              flex: 1,
              child: _buildWhoIsComingSection(),
            ),
          ],
        ),
        const SizedBox(height: 32),
        _buildRSVPButton(),
        const SizedBox(height: 20),
      ],
    );
  }

  // Large tablet/desktop layout
  Widget _buildLargeTabletLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column - About section (wider)
            Expanded(
              flex: 2,
              child: _buildAboutSection(),
            ),
            const SizedBox(width: 48),
            // Right column - Who's coming section
            Expanded(
              flex: 1,
              child: _buildWhoIsComingSection(),
            ),
          ],
        ),
        const SizedBox(height: 48),
        // Center the RSVP button with max width
        SizedBox(
          width: 400,
          child: _buildRSVPButton(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildAboutSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Event',
          style: (isTablet
              ? Theme.of(context).textTheme.headlineMedium
              : Theme.of(context).textTheme.headlineSmall)?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Gender Reveal Party is an exciting celebration that brings together friends and family for an unforgettable moment of joy and anticipation as we discover the gender of our little bundle of joy.',
          style: (isTablet
              ? Theme.of(context).textTheme.bodyLarge
              : Theme.of(context).textTheme.bodyMedium)?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildWhoIsComingSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Who\'s Coming',
          style: (isTablet
              ? Theme.of(context).textTheme.headlineMedium
              : Theme.of(context).textTheme.headlineSmall)?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),

        // Attendees list
        Column(
          children: [
            // Organizer
            _buildAttendeeCard(
              initials: 'EM',
              name: 'Eugene Mpendamapono',
              status: 'Organizer',
              avatarColor: Theme.of(context).colorScheme.primary,
              onAvatarColor: Theme.of(context).colorScheme.onPrimary,
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'HOST',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Other attendees
            _buildAttendeeCard(
              initials: 'MK',
              name: 'Mike Kamau',
              status: 'Attending',
              avatarColor: Theme.of(context).colorScheme.secondary,
              onAvatarColor: Theme.of(context).colorScheme.onSecondary,
              trailing: Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ),

            _buildAttendeeCard(
              initials: 'SK',
              name: 'Sarah Kiprotich',
              status: 'Attending',
              avatarColor: Theme.of(context).colorScheme.tertiary,
              onAvatarColor: Theme.of(context).colorScheme.onTertiary,
              trailing: Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ),

            // More attendees indicator
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              child: Row(
                children: [
                  // Stack of avatar circles showing more people
                  SizedBox(
                    width: 80,
                    height: 48,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                            child: Text(
                              'DM',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Theme.of(context).colorScheme.tertiary,
                            child: Text(
                              'AN',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onTertiary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 40,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: Text(
                              '+5',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'and 5 others are attending',
                      style: (isTablet
                          ? Theme.of(context).textTheme.titleMedium
                          : Theme.of(context).textTheme.titleSmall)?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRSVPButton() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return SizedBox(
      width: double.infinity,
      height: isTablet ? 64 : 56,
      child: FilledButton(
        onPressed: _showRSVPConfirmation,
        child: Text(
          'I\'m Going',

        ),
      ),
    );
  }
}