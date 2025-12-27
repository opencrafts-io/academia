import 'package:academia/features/sherehe/domain/entities/sherehe_user.dart';
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
  final Event event;
  const ShereheDetailsPage({
    super.key,
    required this.eventId,
    required this.event,
  });

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

  void _handleShare() {
    final url =
        'https://academia.opencrafts.io/${ShereheDetailsRoute(eventId: widget.event.id).location}';

    Share.share(
      'You have been invited from Academia to the following event:\n\n '
      '🎉 ${widget.event.eventName}\n\n'
      '📍 Where: ${widget.event.eventLocation}\n'
      '⏰ When: ${ShereheUtils.formatDate(widget.event.eventDate)} at ${ShereheUtils.formatTime(widget.event.eventDate)}\n\n'
      'It’s going to be an amazing experience — don’t miss out!\n\n'
      '🎟 Get your ticket here:\n'
      '$url',
    );
  }

  final List<Attendee> mockAttendees = [
    Attendee(
      id: "att_001",
      userId: "user_001",
      eventId: "event_123",
      ticketId: "ticket_01",
      ticketQuantity: 2,
      user: const ShereheUser(
        id: "user_001",
        username: "eugene_w",
        email: "eugene@example.com",
        name: "Eugene Wachira",
        phone: "+254712345678",
      ),
    ),

    Attendee(
      id: "att_002",
      userId: "user_002",
      eventId: "event_123",
      ticketId: "ticket_02",
      ticketQuantity: 1,
      user: const ShereheUser(
        id: "user_002",
        username: "mary_j",
        email: "mary@example.com",
        name: "Mary Jane",
        phone: "+254711223344",
      ),
    ),

    Attendee(
      id: "att_003",
      userId: "user_003",
      eventId: "event_123",
      ticketId: "ticket_01",
      ticketQuantity: 3,
      user: const ShereheUser(
        id: "user_003",
        username: "kevin_m",
        email: "kevin@example.com",
        name: "Kevin Mutua",
        phone: "+254701122233",
      ),
    ),

    Attendee(
      id: "att_004",
      userId: "user_004",
      eventId: "event_123",
      ticketId: "ticket_03",
      ticketQuantity: 1,
      user: const ShereheUser(
        id: "user_004",
        username: "sarah_k",
        email: "sarah@example.com",
        name: "Sarah Kimani",
        phone: "+254719998877",
      ),
    ),

    Attendee(
      id: "att_005",
      userId: "user_005",
      eventId: "event_123",
      ticketId: "ticket_02",
      ticketQuantity: 2,
      user: const ShereheUser(
        id: "user_005",
        username: "brian_o",
        email: "brian@example.com",
        name: "Brian Otieno",
        phone: "+254700111222",
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                      _handleShare();
                      break;
                    case 'scan':
                      QrCodeScannerRoute(
                        eventId: widget.event.id,
                      ).push(context);
                      break;
                    case 'tickets':
                      EventTicketsRoute(eventId: widget.event.id).push(context);
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
                      leading: const Icon(Icons.confirmation_number_outlined),
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
                widget.event.eventName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.event.eventBannerImage!,
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
                                color: Theme.of(context).colorScheme.onSurface,
                              )
                            : Theme.of(
                                context,
                              ).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                      ),
                      const SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: widget.event.eventGenre!
                                .map((e) => e.trim())
                                .map(
                                  (genre) => Chip(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.secondaryContainer,
                                    label: Text(
                                      genre,
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSecondaryContainer,
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
                        widget.event.eventDescription,
                        style:
                            ResponsiveBreakPoints.isTablet(context) ||
                                ResponsiveBreakPoints.isDesktop(context)
                            ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                height: 1.5,
                              )
                            : Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                      Expanded(child: Text(widget.event.eventLocation)),
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
                          Text(ShereheUtils.formatDate(widget.event.eventDate)),
                        ],
                      ),
                      Row(
                        spacing: 8.0,
                        children: [
                          const Icon(Icons.access_time),
                          Text(ShereheUtils.formatTime(widget.event.eventDate)),
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
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          BlocProvider(
            create: (_) => AttendeeBloc(getAttendee: sl()),
            child: AttendeesList(
              eventId: widget.event.id,
              organizerId: widget.event.organizerId,
              userId: userId,
              attendees: mockAttendees,
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
                TicketFlowRoute(eventId: widget.event.id).push(context);
              },
              child: const Text("I'm Going"),
            ),
          ),
        ),
      ),
    );
  }
}
