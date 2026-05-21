import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';

final List<InviteModel> dummyEventLinks = [
  InviteModel(
    id: "6dff3c91-053b-4a40-b172-145614fdf403",
    ticketId: "a90f4ba4-9bbe-4994-b453-356771ef282c",
    token: "0438f9bbecb99a9159e28ee15615d6c93f5eeb40db73b564776a21d8dc2f3da1",
    expiresAt: DateTime.now().add(const Duration(days: 7)),
    maxUses: 100,
    usedCount: 24,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now(),
  ),
  InviteModel(
    id: "0dbd57b9-5126-46cf-b7d0-1f77fd1e0c6a",
    ticketId: "3a4e5f11-7777-4994-b453-356771ef282c",
    token: "f4a9bcce91122aa9159e28ee15615d6c93f5eeb40db73b564776a21d8dc111",
    expiresAt: DateTime.now().add(const Duration(days: 3)),
    maxUses: 50,
    usedCount: 42,
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    updatedAt: DateTime.now(),
  ),
  InviteModel(
    id: "ac4f7d3c-b6c5-43c4-bf0f-e2a3d5d7e001",
    ticketId: "f90f4ba4-9bbe-4994-b453-356771ef2001",
    token: "ee89f9bbecb99a9159e28ee15615d6c93f5eeb40db73b564776a21d8dc299",
    expiresAt: DateTime.now().subtract(const Duration(hours: 5)),
    maxUses: 200,
    usedCount: 200,
    createdAt: DateTime.now().subtract(const Duration(days: 10)),
    updatedAt: DateTime.now(),
  ),
];

class EventLinksScreen extends StatefulWidget {
  final String eventId;

  const EventLinksScreen({super.key, required this.eventId});

  @override
  State<EventLinksScreen> createState() => _EventLinksScreenState();
}

class _EventLinksScreenState extends State<EventLinksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(title: const Text("Event Links")),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.separated(
              itemCount: dummyEventLinks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final invite = dummyEventLinks[index];

                return PrivateLinkWidget(
                  index: index,
                  invite: invite,
                  linkType: LinkType.event,
                );
              },
            ),
          ),
          SliverPadding(padding: const EdgeInsets.only(bottom: 80)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text("Create Link"),
      ),
    );
  }
}
