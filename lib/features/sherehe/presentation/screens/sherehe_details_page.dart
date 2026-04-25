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
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ShereheDetailsPage extends StatefulWidget {
  final String? eventId;
  final Event? event;
  final String? invite;

  const ShereheDetailsPage({super.key, this.eventId, this.event, this.invite});

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
      LoadShereheDetails(
        eventId: widget.eventId ?? '',
        initialEvent: widget.event,
        invite: widget.invite,
      ),
    );

    if (widget.eventId != null) {
      context.read<GetEventScannerByUserIdBloc>().add(
        GetEventScannerByUserId(eventId: widget.eventId!),
      );
    }
  }

  double _getExpandedHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width * (9 / 16); // 16:9 ratio
  }

  String _normalizeDescription(String text) {
    // Replace 3+ line breaks with just 2
    return text.replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
  }

  Future<XFile?> _downloadImage(String url) async {
    try {
      final dio = Dio();

      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/event_share.jpg';

      await dio.download(
        url,
        filePath,
        options: Options(
          responseType: ResponseType.bytes, // ensures raw bytes
        ),
      );

      return XFile(filePath);
    } catch (e) {
      return null;
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
          // If the page was accessed via an invite link, we also fetch the scanner info to determine if the user can access the scanning feature
          if (widget.invite != null) {
            context.read<GetEventScannerByUserIdBloc>().add(
              GetEventScannerByUserId(eventId: state.event.id),
            );
          }

          DateTime normalize(DateTime d) => DateTime(d.year, d.month, d.day);

          final eventEndDate = normalize(
            DateTime.parse(state.event.endDate).toLocal(),
          );

          final today = normalize(DateTime.now());

          final isPastEvent = today.isAfter(eventEndDate);
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
                    BlocBuilder<
                      GetEventScannerByUserIdBloc,
                      GetEventScannerByUserIdState
                    >(
                      builder: (context, scannerState) {
                        final isOrganizer =
                            userId != null && userId == state.event.organizerId;

                        final isScanner =
                            scannerState is GetEventScannerByUserIdSuccess;

                        final canScan = isOrganizer || isScanner;

                        return PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (value) async {
                            switch (value) {
                              case 'share':
                                final url =
                                    'https://academia.opencrafts.io${ShereheDetailsRoute(eventId: state.event.id).location}';

                                final box =
                                    context.findRenderObject() as RenderBox?;

                                final imageUrl = state.event.eventPosterImage;

                                XFile? imageFile;

                                if (imageUrl != null) {
                                  imageFile = await _downloadImage(imageUrl);
                                }

                                final text =
                                    'You have been invited from Academia to the following event:\n\n '
                                    '🎉 ${state.event.eventName}\n\n'
                                    '📍 Where: ${state.event.eventLocation}\n'
                                    '⏰ When: ${ShereheUtils.formatDate(state.event.startDate)} at ${ShereheUtils.formatTime(state.event.startDate)}\n\n'
                                    '🎟 Get your ticket here:\n$url';

                                if (imageFile != null) {
                                  await Share.shareXFiles(
                                    [imageFile],
                                    text: text,
                                    sharePositionOrigin: box != null
                                        ? box.localToGlobal(Offset.zero) &
                                              box.size
                                        : null,
                                  );
                                } else {
                                  await Share.share(
                                    text,
                                    sharePositionOrigin: box != null
                                        ? box.localToGlobal(Offset.zero) &
                                              box.size
                                        : null,
                                  );
                                }
                                break;

                              case 'scan':
                                if (canScan) {
                                  QrCodeScannerRoute(
                                    eventId: state.event.id,
                                  ).push(context);
                                }
                                break;

                              case 'dashboard':
                                if (isOrganizer) {
                                  OrganizerDashboardRoute(
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
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'share',
                              child: ListTile(
                                leading: Icon(Icons.share),
                                title: Text('Share Event'),
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                              ),
                            ),

                            if (canScan)
                              const PopupMenuItem(
                                value: 'scan',
                                child: ListTile(
                                  leading: Icon(Icons.qr_code_scanner),
                                  title: Text('Scan my Event'),
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),

                            if (isOrganizer)
                              const PopupMenuItem(
                                value: 'dashboard',
                                child: ListTile(
                                  leading: Icon(Icons.dashboard),
                                  title: Text('Dashboard'),
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),

                            const PopupMenuItem(
                              value: 'tickets',
                              child: ListTile(
                                leading: Icon(
                                  Icons.confirmation_number_outlined,
                                ),
                                title: Text('My Tickets'),
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                          ],
                        );
                      },
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
                        Text(
                          'About Event',
                          style:
                              ResponsiveBreakPoints.isTablet(context) ||
                                  ResponsiveBreakPoints.isDesktop(context)
                              ? Theme.of(context).textTheme.headlineMedium!
                                    .copyWith(fontWeight: FontWeight.bold)
                              : Theme.of(context).textTheme.headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 12),

                        if (state.event.eventGenre != null &&
                            state.event.eventGenre!.isNotEmpty)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: state.event.eventGenre!
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

                        Text(
                          _normalizeDescription(state.event.eventDescription),
                          style:
                              ResponsiveBreakPoints.isTablet(context) ||
                                  ResponsiveBreakPoints.isDesktop(context)
                              ? Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                        const SizedBox(height: 10),
                        Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        state.event.eventLocation,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        ShereheDetailsScheduleCard(
                          startDate: state.event.startDate,
                          endDate: state.event.endDate,
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
                    onPressed: isPastEvent
                        ? null
                        : () {
                            TicketFlowRoute(
                              eventId: state.event.id,
                            ).push(context);
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
