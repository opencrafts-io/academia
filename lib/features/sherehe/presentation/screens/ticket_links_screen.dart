import 'package:academia/core/clippers/spinning_scallop_indicator.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TicketLinksScreen extends StatefulWidget {
  final String ticketId;

  const TicketLinksScreen({super.key, required this.ticketId});

  @override
  State<TicketLinksScreen> createState() => _TicketLinksScreenState();
}

class _TicketLinksScreenState extends State<TicketLinksScreen> {
  @override
  void initState() {
    super.initState();

    context.read<TicketLinkBloc>().add(
      GetTicketInvites(ticketId: widget.ticketId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketLinkBloc, TicketLinkState>(
      listener: (context, state) {
        if (state is CreateTicketInviteSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        } else if (state is CreateTicketInviteErrorState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        } else if (state is UpdateTicketInviteSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Ticket link updated successfully."),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        } else if (state is UpdateTicketInviteErrorState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        } else if (state is DeleteTicketInviteSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        } else if (state is DeleteTicketInviteErrorState) {
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
            SliverAppBar.large(title: const Text("Ticket Links")),
            BlocBuilder<TicketLinkBloc, TicketLinkState>(
              builder: (context, state) {
                if (state is GetAllTicketInvitesLoading) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: const SpinningScallopIndicator()),
                  );
                } else if (state is GetAllTicketInvitesErrorState) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        "Failed to load ticket links.",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  );
                } else if (state is GetAllTicketInvitesSuccess) {
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
                              "No ticket links created yet.",
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
                          separatorBuilder: (_, _) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final invite = state.invites[index];
      
                            return PrivateLinkWidget(
                              index: index,
                              invite: invite,
                              linkType: LinkType.ticket,
                              onEdit: () => showEditTicketLinkBottomSheet(
                                context: context,
                                ticketId: widget.ticketId,
                                inviteId: invite.id,
                                maxUses: invite.maxUses,
                                expiresAt: invite.expiresAt,
                              ),
                              onDelete: () => showDeleteTicketInviteDialog(
                                context: context,
                                ticketId: widget.ticketId,
                                inviteId: invite.id,
                              ),
                            );
                          },
                        ),
                        SliverPadding(padding: const EdgeInsets.only(bottom: 80)),
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
          onPressed: () =>
              showCreateTicketLinkBottomSheet(context, widget.ticketId),
          icon: const Icon(Icons.add),
          label: const Text("Create Link"),
        ),
      ),
    );
  }
}
