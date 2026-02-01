import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizerDashboardPage extends StatefulWidget {
  final String eventId;

  const OrganizerDashboardPage({super.key, required this.eventId});

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
    context.read<TicketStatsBloc>().add(
      GetTicketStats(eventId: widget.eventId),
    );
    context.read<AllAttendeesBloc>().add(
      FetchAllAttendees(eventId: widget.eventId, page: 1, limit: 20),
    );
  }

  void _showMoreActionsBottomSheet({
    required BuildContext context,
    required String title,
    required String ticketId,
    required int currentQuantity,
  }) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => Container(
        height: 280,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            Divider(),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("Increase Ticket Quantity"),
              onTap: () {
                Navigator.pop(context); // close bottom sheet
                _showIncreaseQuantityDialog(
                  context: context,
                  ticketName: title,
                  ticketId: ticketId,
                  currentQuantity: currentQuantity,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showIncreaseQuantityDialog({
    required BuildContext context,
    required String ticketName,
    required String ticketId,
    required int currentQuantity,
  }) {
    final controller = TextEditingController();
    String? errorText;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Increase $ticketName Tickets"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Enter how many tickets you want to add."),
                  const SizedBox(height: 12),
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    onChanged: (_) {
                      if (errorText != null) {
                        setState(() => errorText = null);
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Quantity",
                      hintText: "e.g. 50",
                      border: OutlineInputBorder(),
                      errorText: errorText,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                BlocBuilder<TicketStatsBloc, TicketStatsState>(
                  builder: (context, state) {
                    return state is UpdateTicketLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          )
                        : FilledButton(
                            onPressed: () {
                              final qty = int.tryParse(controller.text);

                              if (qty == null || qty <= 0) {
                                setState(() {
                                  errorText = "Enter a number greater than 0";
                                });
                                return;
                              }

                              context.read<TicketStatsBloc>().add(
                                UpdateTicketQuantity(
                                  ticketId: ticketId,
                                  ticketQuantity: currentQuantity + qty,
                                ),
                              );

                              Navigator.pop(context);
                            },
                            child: const Text("Confirm"),
                          );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketStatsBloc, TicketStatsState>(
      listener: (context, state) {
        if (state is UpdateTicketSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Ticket updated successfully."),
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.horizontal,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
          // Refresh ticket stats
          context.read<TicketStatsBloc>().add(
            GetTicketStats(eventId: widget.eventId),
          );
        } else if (state is UpdateTicketError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error: ${state.message}"),
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.horizontal,
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
            ),
          );
        }
      },
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<AttendeesAndScannerStatsBloc>().add(
              GetAttendeesAndScanners(eventId: widget.eventId),
            );
            context.read<TicketStatsBloc>().add(
              GetTicketStats(eventId: widget.eventId),
            );
            context.read<AllAttendeesBloc>().add(
              FetchAllAttendees(eventId: widget.eventId, page: 1, limit: 20),
            );
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                pinned: true,
                title: const Text("Event Dashboard"),
              ),
              BlocBuilder<
                AttendeesAndScannerStatsBloc,
                AttendeesAndScannerStatsState
              >(
                builder: (context, state) {
                  if (state is LoadedState) {
                    return SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverGrid(
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
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          _SummaryCard(
                            icon: Icons.qr_code_scanner,
                            title: "Scanners",
                            value: state.stats.scanners.toString(),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ]),
                      ),
                    );
                  } else if (state is LoadingState) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(child: SpinningScallopIndicator()),
                      ),
                    );
                  } else if (state is ErrorState) {
                    return SliverToBoxAdapter(
                      child: Center(
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
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
              _SectionHeader(title: "Ticket Availability"),
              BlocBuilder<TicketStatsBloc, TicketStatsState>(
                builder: (context, state) {
                  if (state is StatsLoadedState) {
                    return SliverList(
                      delegate: SliverChildListDelegate(
                        state.stats
                            .map(
                              (stats) => _TicketTypeTile(
                                type: stats.ticketName,
                                sold: stats.ticketsSold,
                                remaining: stats.ticketsRemaining,
                                onTap: () => _showMoreActionsBottomSheet(
                                  context: context,
                                  title: stats.ticketName,
                                  ticketId: stats.ticketId,
                                  currentQuantity: stats.ticketsRemaining,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  } else if (state is StatsLoadingState) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(child: SpinningScallopIndicator()),
                      ),
                    );
                  } else if (state is StatsErrorState) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Failed to load ticket stats.",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
              _SectionHeader(
                title: "Attendees",
                onAction: () =>
                    AllAttendeesRoute(eventId: widget.eventId).push(context),
              ),
              BlocBuilder<AllAttendeesBloc, AllAttendeesState>(
                builder: (context, state) {
                  if (state is AllAttendeesStateLoaded) {
                    if (state.attendees.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.person_off, size: 60),
                                SizedBox(height: 16),
                                Text(
                                  "No attendees yet",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          state.attendees
                              .take(5)
                              .map(
                                (attendee) => UserTile(
                                  name: attendee.user?.username ?? "Guest",
                                  subtitle:
                                      attendee.ticket?.ticketName ??
                                      "Unknown Ticket",
                                  icon: Icons.person_outline,
                                ),
                              )
                              .toList(),
                        ),
                      );
                    }
                  } else if (state is AllAttendeesStateLoading ||
                      state is AllAttendeesStatePaginationLoading) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(child: SpinningScallopIndicator()),
                      ),
                    );
                  } else if (state is AllAttendeesStateError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Failed to load attendees.",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
              _SectionHeader(
                title: "Event Scanners",
                onAction: () =>
                    AllScannersRoute(eventId: widget.eventId).push(context),
              ),
              SliverToBoxAdapter(
                child: _AddScannerTile(
                  onTap: () {
                    // AllScannersRoute(eventId: widget.eventId).push(context);
                  },
                ),
              ),
              BlocBuilder<AllScannersBloc, AllScannersState>(
                builder: (context, state) {
                  if (state is AllScannersStateLoaded) {
                    if (state.scanners.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.qr_code_scanner, size: 60),
                                SizedBox(height: 16),
                                Text(
                                  "No scanners yet",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          state.scanners
                              .take(5)
                              .map(
                                (scanner) => UserTile(
                                  name: scanner.role,
                                  subtitle: "Can scan tickets",
                                  icon: Icons.qr_code,
                                  onTap: () {},
                                ),
                              )
                              .toList(),
                        ),
                      );
                    }
                  } else if (state is AllScannersStateLoading ||
                      state is AllScannersStatePaginationLoading) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(child: SpinningScallopIndicator()),
                      ),
                    );
                  } else if (state is AllScannersStateError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Failed to load scanners.",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),

              const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
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
  final Color color;

  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
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
    );
  }
}

class _TicketTypeTile extends StatelessWidget {
  final String type;
  final int sold;
  final int remaining;
  final VoidCallback onTap;

  const _TicketTypeTile({
    required this.type,
    required this.sold,
    required this.remaining,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.confirmation_number_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(width: 12),

                // Main content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ticket name
                      Text(
                        type,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          _StatPill(
                            label: "Sold",
                            value: sold.toString(),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          _StatPill(
                            label: "Remaining",
                            value: remaining.toString(),
                            color: remaining > 0
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.error,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatPill({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "$label: $value",
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AddScannerTile extends StatelessWidget {
  final VoidCallback onTap;

  const _AddScannerTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.person_add_alt_1,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add Scanner",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Give someone permission to scan tickets",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withValues(alpha: 0.75),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onAction;

  const _SectionHeader({required this.title, this.onAction});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 12),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (onAction != null)
              TextButton(onPressed: onAction, child: const Text("View all")),
          ],
        ),
      ),
    );
  }
}
