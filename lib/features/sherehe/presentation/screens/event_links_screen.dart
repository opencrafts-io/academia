import 'package:academia/core/clippers/spinning_scallop_indicator.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class EventLinksScreen extends StatefulWidget {
  final String eventId;
  final String eventName;
  final String eventLocation;
  final String eventStartDate;
  final String eventEndDate;
  final String? eventPosterImage;

  const EventLinksScreen({
    super.key,
    required this.eventId,
    required this.eventName,
    required this.eventLocation,
    required this.eventStartDate,
    required this.eventEndDate,
    this.eventPosterImage,
  });

  @override
  State<EventLinksScreen> createState() => _EventLinksScreenState();
}

class _EventLinksScreenState extends State<EventLinksScreen> {
  @override
  void initState() {
    super.initState();

    context.read<EventLinkBloc>().add(GetEventInvites(eventId: widget.eventId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventLinkBloc, EventLinkState>(
      listener: (context, state) {
        if (state is CreateEventInviteSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        } else if (state is CreateEventInviteErrorState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        } else if (state is UpdateEventInviteSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Ticket link updated successfully."),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        } else if (state is UpdateEventInviteErrorState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        } else if (state is DeleteEventInviteSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        } else if (state is DeleteEventInviteErrorState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.large(title: const Text("Event Links")),
            BlocBuilder<EventLinkBloc, EventLinkState>(
              builder: (context, state) {
                if (state is GetAllEventInvitesLoading) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: const SpinningScallopIndicator()),
                  );
                } else if (state is GetAllEventInvitesErrorState) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        "Failed to load event links.",
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
                } else if (state is GetAllEventInvitesSuccess) {
                  if (state.invites.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.link_off_rounded,
                              size: 64,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "No event links created yet.",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: MultiSliver(
                      children: [
                        SliverList.separated(
                          itemCount: state.invites.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final invite = state.invites[index];

                            return PrivateLinkWidget(
                              index: index,
                              eventName: widget.eventName,
                              eventLocation: widget.eventLocation,
                              eventStartDate: widget.eventStartDate,
                              eventEndDate: widget.eventEndDate,
                              eventPosterImage: widget.eventPosterImage,
                              invite: invite,
                              linkType: LinkType.event,
                              onEdit: () => showEditLinkBottomSheet(
                                context: context,
                                eventId: widget.eventId,
                                inviteId: invite.id,
                                maxUses: invite.maxUses,
                                expiresAt: invite.expiresAt,
                              ),
                              onDelete: () => showDeleteInviteDialog(
                                context: context,
                                eventId: widget.eventId,
                                inviteId: invite.id,
                              ),
                            );
                          },
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(bottom: 80),
                        ),
                      ],
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showCreateLinkBottomSheet(context, widget.eventId),
          icon: const Icon(Icons.add),
          label: const Text("Create Link"),
        ),
      ),
    );
  }
}
