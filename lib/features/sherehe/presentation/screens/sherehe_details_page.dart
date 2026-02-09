import 'package:academia/core/core.dart';
import 'package:academia/injection_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:academia/features/sherehe/sherehe.dart';
import 'package:academia/constants/constants.dart';
import 'package:academia/config/config.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class ShereheDetailsPage extends StatefulWidget {
  final String eventId;
  final Event? event;

  const ShereheDetailsPage({super.key, required this.eventId, this.event});

  @override
  State<ShereheDetailsPage> createState() => _ShereheDetailsPageState();
}

class _ShereheDetailsPageState extends State<ShereheDetailsPage> {
  String? userId;

  @override
  void initState() {
    super.initState();

    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadedState) {
      userId = profileState.profile.id;
    }

    context.read<ShereheDetailsBloc>().add(
      LoadShereheDetails(eventId: widget.eventId, initialEvent: widget.event),
    );
  }

  double _getExpandedHeight(BuildContext context) {
    if (ResponsiveBreakPoints.isMobile(context)) {
      return MediaQuery.of(context).size.height * 0.40;
    } else if (ResponsiveBreakPoints.isTablet(context)) {
      return MediaQuery.of(context).size.height * 0.4;
    } else {
      return 500.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShereheDetailsBloc, ShereheDetailsState>(
      builder: (context, state) {
        if (state is ShereheDetailsLoading) {
          return Scaffold(
            body: const Center(child: SpinningScallopIndicator()),
          );
        } else if (state is ShereheDetailsError) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Failed to load event details. Please try again later.\n\n${state.message}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        } else if (state is ShereheDetailsLoaded) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: _getExpandedHeight(context),
                  pinned: true,
                  leading: IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  actions: [
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) {
                        switch (value) {
                          case 'share':
                            final url =
                                'https://academia.opencrafts.io/${ShereheDetailsRoute(eventId: state.event.id).location}';

                            Share.share(
                              'You have been invited from Academia to the following event:\n\n '
                              '🎉 ${state.event.eventName}\n\n'
                              '📍 Where: ${state.event.eventLocation}\n'
                              '⏰ When: ${ShereheUtils.formatDate(state.event.eventDate)} at ${ShereheUtils.formatTime(state.event.eventDate)}\n\n'
                              'It’s going to be an amazing experience — don’t miss out!\n\n'
                              '🎟 Get your ticket here:\n'
                              '$url',
                            );
                            break;
                          case 'scan':
                            if (userId != null &&
                                userId == state.event.organizerId) {
                              QrCodeScannerRoute(
                                eventId: state.event.id,
                              ).push(context);
                            }

                            break;
                          case 'tickets':
                            context.push(
                              EventTicketsRoute(
                                eventId: state.event.id,
                              ).location,
                              extra: state.event,
                            );
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          value: 'share',
                          child: ListTile(
                            leading: const Icon(Icons.share),
                            title: const Text('Share Event'),
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                        if (userId != null && userId == state.event.organizerId)
                          PopupMenuItem(
                            value: 'scan',
                            child: ListTile(
                              leading: const Icon(Icons.qr_code_scanner),
                              title: const Text('Scan my Event'),
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                        PopupMenuItem(
                          value: 'tickets',
                          child: ListTile(
                            leading: const Icon(
                              Icons.confirmation_number_outlined,
                            ),
                            title: const Text('My Tickets'),
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ],
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      state.event.eventName,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (state.event.eventBannerImage != null)
                          CachedNetworkImage(
                            imageUrl: state.event.eventBannerImage!,
                            fit: BoxFit.cover,
                            errorWidget: (context, child, error) {
                              return Container(
                                width: double.infinity,
                                color: Theme.of(
                                  context,
                                ).colorScheme.errorContainer,
                                child: const Icon(Icons.image_not_supported),
                              );
                            },
                          )
                        else
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                  Theme.of(
                                    context,
                                  ).colorScheme.secondaryContainer,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.event,
                                size: 64,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                            ),
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
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(
                    ResponsiveBreakPoints.isMobile(context) ? 16.0 : 32.0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About Event',
                              style:
                                  ResponsiveBreakPoints.isTablet(context) ||
                                      ResponsiveBreakPoints.isDesktop(context)
                                  ? Theme.of(
                                      context,
                                    ).textTheme.headlineMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    )
                                  : Theme.of(
                                      context,
                                    ).textTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                            ),
                            const SizedBox(height: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: state.event.eventGenre!
                                      .map((e) => e.trim())
                                      .map(
                                        (genre) => Chip(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          backgroundColor: Theme.of(
                                            context,
                                          ).colorScheme.secondaryContainer,
                                          label: Text(
                                            genre,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                            Text(
                              state.event.eventDescription,
                              style:
                                  ResponsiveBreakPoints.isTablet(context) ||
                                      ResponsiveBreakPoints.isDesktop(context)
                                  ? Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                      height: 1.5,
                                    )
                                  : Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                      height: 1.5,
                                    ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.location_on),
                            const SizedBox(width: 8),
                            Expanded(child: Text(state.event.eventLocation)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          spacing: 16.0,
                          children: [
                            Row(
                              spacing: 8.0,
                              children: [
                                const Icon(Icons.calendar_month),
                                Text(
                                  ShereheUtils.formatDate(
                                    state.event.eventDate,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 8.0,
                              children: [
                                const Icon(Icons.access_time),
                                Text(
                                  ShereheUtils.formatTime(
                                    state.event.eventDate,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(
                    ResponsiveBreakPoints.isMobile(context) ? 16.0 : 32.0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "Who's Coming",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                BlocProvider(
                  key: ValueKey(state.event.id),
                  create: (_) =>
                      AttendeeBloc(getAttendee: sl())
                        ..add(FetchAttendees(eventId: state.event.id)),
                  child: AttendeesList(
                    eventId: state.event.id,
                    organizerId: state.event.organizerId,
                    userId: userId,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: ResponsiveBreakPoints.isMobile(context) ? 50 : 56,
                  child: FilledButton(
                    onPressed: () {
                      TicketFlowRoute(eventId: state.event.id).push(context);
                    },
                    child: const Text("I'm Going"),
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
