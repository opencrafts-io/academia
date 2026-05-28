import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllEventTicketsScreen extends StatefulWidget {
  final String eventId;
  final String eventName;
  final String eventLocation;
  final String eventStartDate;
  final String eventEndDate;
  final String? eventPosterImage;

  const AllEventTicketsScreen({
    super.key,
    required this.eventId,
    required this.eventName,
    required this.eventLocation,
    required this.eventStartDate,
    required this.eventEndDate,
    this.eventPosterImage,
  });

  @override
  State<AllEventTicketsScreen> createState() => _AllEventTicketsScreenState();
}

class _AllEventTicketsScreenState extends State<AllEventTicketsScreen> {
  void _showMoreActionsBottomSheet({
    required BuildContext context,
    required String title,
    required String ticketId,
    required int currentQuantity,
  }) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (modalContext) => Container(
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
                Navigator.pop(modalContext); // close bottom sheet
                _showIncreaseQuantityDialog(
                  context: context,
                  ticketName: title,
                  ticketId: ticketId,
                  currentQuantity: currentQuantity,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.link_outlined),
              title: Text("Ticket Links"),
              onTap: () {
                Navigator.pop(modalContext); // close bottom sheet
                TicketLinksRoute(
                  eventId: widget.eventId,
                  ticketId: ticketId,
                  eventName: widget.eventName,
                  eventLocation: widget.eventLocation,
                  eventStartDate: widget.eventStartDate,
                  eventEndDate: widget.eventEndDate,
                  eventPosterImage: widget.eventPosterImage,
                ).push(context);
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
      builder: (modalContext) {
        return BlocProvider.value(
          value: context.read<TicketStatsBloc>(),
          child: StatefulBuilder(
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
          ),
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
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              pinned: true,
              title: const Text("Event Tickets"),
            ),
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
                              scope: stats.scope,
                              remaining: stats.ticketsRemaining,
                              progress:
                                  stats.ticketsSold /
                                  (stats.ticketsSold + stats.ticketsRemaining),
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
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: SpinningScallopIndicator()),
                  );
                } else if (state is StatsErrorState) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
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
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
            SliverPadding(padding: const EdgeInsets.only(bottom: 80)),
          ],
        ),
        floatingActionButton: BlocBuilder<TicketStatsBloc, TicketStatsState>(
          builder: (context, state) {
            if (state is StatsLoadedState) {
              if (state.stats.first.ticketName == 'Free Ticket') {
                return const SizedBox.shrink();
              }

              return FloatingActionButton.extended(
                onPressed: () => CreateTicketRoute(
                  isMultiDayEvent: false,
                  eventStartDateTime: DateTime.now(),
                  eventEndDateTime: DateTime.now(),
                ).push(context),
                icon: const Icon(Icons.add),
                label: const Text("Create Event Ticket"),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _TicketTypeTile extends StatelessWidget {
  final String type;
  final int sold;
  final int remaining;
  final VoidCallback onTap;
  final double progress;
  final String scope;

  const _TicketTypeTile({
    required this.type,
    required this.sold,
    required this.remaining,
    required this.onTap,
    required this.progress,
    required this.scope,
  });

  @override
  Widget build(BuildContext context) {
    final scopeType = ScopeTypesX.fromBackend(scope);
    final percentage = (progress * 100).clamp(0, 100).toInt();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
        elevation: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsetsGeometry.all(16.0),
            child: Column(
              spacing: 20,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        type,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: scopeType == ScopeTypes.public
                            ? Theme.of(context).colorScheme.primaryContainer
                            : scopeType == ScopeTypes.institution
                            ? Theme.of(context).colorScheme.secondaryContainer
                            : Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        scopeType.label,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: scopeType == ScopeTypes.public
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer
                                  : scopeType == ScopeTypes.institution
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.onSecondaryContainer
                                  : Theme.of(
                                      context,
                                    ).colorScheme.onTertiaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StatPill(
                      label: "Sold",
                      value: sold.toString(),
                      cardColor: Theme.of(context).colorScheme.primaryContainer,
                      textColor: Theme.of(
                        context,
                      ).colorScheme.onPrimaryContainer,
                    ),
                    _StatPill(
                      label: "Remaining",
                      value: remaining.toString(),
                      cardColor: remaining > 0
                          ? Theme.of(context).colorScheme.secondaryContainer
                          : Theme.of(context).colorScheme.errorContainer,
                      textColor: remaining > 0
                          ? Theme.of(context).colorScheme.onSecondaryContainer
                          : Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ],
                ),
                Column(
                  spacing: 5,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sales Progress",
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                        ),

                        Text(
                          "$percentage% Reached",
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.secondary.withValues(alpha: 0.25),
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
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
  final Color cardColor;
  final Color textColor;

  const _StatPill({
    required this.label,
    required this.value,
    required this.cardColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label.toUpperCase(),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
