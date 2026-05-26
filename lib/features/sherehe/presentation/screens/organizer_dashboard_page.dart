import 'package:academia/config/config.dart';
import 'package:academia/constants/responsive_break_points.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class OrganizerDashboardPage extends StatefulWidget {
  final String eventId;
  final String eventName;
  final String eventLocation;
  final String eventStartDate;
  final String eventEndDate;
  final String? eventPosterImage;

  const OrganizerDashboardPage({
    super.key,
    required this.eventId,
    required this.eventName,
    required this.eventLocation,
    required this.eventStartDate,
    required this.eventEndDate,
    this.eventPosterImage,
  });

  @override
  State<OrganizerDashboardPage> createState() => _OrganizerDashboardPageState();
}

class _OrganizerDashboardPageState extends State<OrganizerDashboardPage> {
  @override
  void initState() {
    super.initState();

    context.read<AttendeesAndScannerStatsBloc>().add(
      GetAttendeesAndScanners(eventId: widget.eventId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AttendeesAndScannerStatsBloc>().add(
            GetAttendeesAndScanners(eventId: widget.eventId),
          );
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              pinned: true,
              title: const Text("Event Dashboard"),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: MultiSliver(
                children: [
                  BlocBuilder<
                    AttendeesAndScannerStatsBloc,
                    AttendeesAndScannerStatsState
                  >(
                    builder: (context, state) {
                      if (state is LoadedState) {
                        return SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 1.0,
                              ),
                          delegate: SliverChildListDelegate.fixed([
                            _SummaryCard(
                              icon: Icons.people_outline,
                              title: "Attendees",
                              value: state.stats.attendees.toString(),
                            ),
                            _SummaryCard(
                              icon: Icons.qr_code_scanner,
                              title: "Scanners",
                              value: state.stats.scanners.toString(),
                            ),
                          ]),
                        );
                      } else if (state is LoadingState) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(child: SpinningScallopIndicator()),
                        );
                      } else if (state is ErrorState) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Failed to load stats.",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Organizer Actions",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SliverGrid(
                    delegate: SliverChildListDelegate.fixed([
                      _MenuCard(
                        iconPath: Assets.icons.dashboardIconsLink.path,
                        title: 'Event Links',
                        onTap: () => EventLinksRoute(
                          eventId: widget.eventId,
                          eventName: widget.eventName,
                          eventLocation: widget.eventLocation,
                          eventStartDate: widget.eventStartDate,
                          eventEndDate: widget.eventEndDate,
                          eventPosterImage: widget.eventPosterImage,
                        ).push(context),
                      ),
                      _MenuCard(
                        iconPath: Assets.icons.dashboardIconsNotebook.path,
                        title: 'Ticket Management',
                        onTap: () => AllEventTicketsRoute(
                          eventId: widget.eventId,
                          eventName: widget.eventName,
                          eventLocation: widget.eventLocation,
                          eventStartDate: widget.eventStartDate,
                          eventEndDate: widget.eventEndDate,
                          eventPosterImage: widget.eventPosterImage,
                        ).push(context),
                      ),
                      _MenuCard(
                        iconPath: Assets.icons.dashboardIconsMobile.path,
                        title: 'Scanners',
                        onTap: () => AllScannersRoute(
                          eventId: widget.eventId,
                          eventName: widget.eventName,
                          eventLocation: widget.eventLocation,
                          eventStartDate: widget.eventStartDate,
                          eventEndDate: widget.eventEndDate,
                          eventPosterImage: widget.eventPosterImage,
                        ).push(context),
                      ),
                      _MenuCard(
                        iconPath: Assets.icons.dashboardIconsBoy.path,
                        title: 'Attendees',
                        onTap: () => AllAttendeesRoute(
                          eventId: widget.eventId,
                          eventName: widget.eventName,
                          eventLocation: widget.eventLocation,
                          eventStartDate: widget.eventStartDate,
                          eventEndDate: widget.eventEndDate,
                          eventPosterImage: widget.eventPosterImage,
                        ).push(context),
                      ),
                    ]),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveBreakPoints.isMobile(context)
                          ? 2
                          : 6,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
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

class _MenuCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const _MenuCard({
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(1),
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconPath, width: 48, height: 48),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.secondary.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Theme.of(context).colorScheme.secondary),
            ),
            const Spacer(),
            Text(
              value,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
