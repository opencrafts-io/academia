import 'package:academia/features/sherehe/domain/entities/invite.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';

final List<Invite> dummyTicketLinks = [
  Invite(
    id: "6dff3c91-053b-4a40-b172-145614fdf403",
    eventId: "event-123",
    token: "0438f9bbecb99a9159e28ee15615d6c93f5eeb40db73b564776a21d8dc2f3da1",
    expiresAt: '2024-12-31T23:59:59Z',
    maxUses: 100,
    usedCount: 24,
    createdAt: '2024-01-01T12:00:00Z',
    updatedAt: '2024-01-01T12:00:00Z',
  ),
  Invite(
    id: "0dbd57b9-5126-46cf-b7d0-1f77fd1e0c6a",
    eventId: "event-123",
    token: "f4a9bcce91122aa9159e28ee15615d6c93f5eeb40db73b564776a21d8dc111",
    expiresAt: '2024-01-03T23:59:59Z',
    maxUses: 50,
    usedCount: 42,
    createdAt: '2024-01-01T12:00:00Z',
    updatedAt: '2024-01-01T12:00:00Z',
  ),
  Invite(
    id: "ac4f7d3c-b6c5-43c4-bf0f-e2a3d5d7e001",
    eventId: "event-123",
    token: "ee89f9bbecb99a9159e28ee15615d6c93f5eeb40db73b564776a21d8dc299",
    expiresAt: '2024-01-03T23:59:59Z',
    maxUses: 200,
    usedCount: 200,
    createdAt: '2024-01-01T12:00:00Z',
    updatedAt: '2024-01-01T12:00:00Z',
  ),
];

class TicketLinksScreen extends StatefulWidget {
  final String ticketId;

  const TicketLinksScreen({super.key, required this.ticketId});

  @override
  State<TicketLinksScreen> createState() => _TicketLinksScreenState();
}

class _TicketLinksScreenState extends State<TicketLinksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text("Create Link"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(title: const Text("Ticket Links")),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.separated(
              itemCount: dummyTicketLinks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final invite = dummyTicketLinks[index];

                return PrivateLinkWidget(
                  index: index,
                  invite: invite,
                  linkType: LinkType.ticket,
                );
              },
            ),
          ),
          SliverPadding(padding: const EdgeInsets.only(bottom: 80)),
        ],
      ),
    );
  }
}
