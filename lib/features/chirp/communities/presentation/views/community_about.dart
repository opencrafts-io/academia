import 'package:academia/config/router/routes.dart';
import 'package:flutter/material.dart';

class CommunityAbout extends StatefulWidget {
  final bool isModerator;
  final String communityId;
  final String userId;
  final List<String> guidelines;

  const CommunityAbout({
    super.key,
    this.isModerator = false,
    required this.communityId,
    required this.userId,
    required this.guidelines,
  });

  @override
  State<CommunityAbout> createState() => _CommunityAboutState();
}

class _CommunityAboutState extends State<CommunityAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Community Guidelines",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),

              // Guidelines list
              widget.guidelines.isEmpty && widget.isModerator
                  ? Center(
                      child: FilledButton.icon(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          AddCommunityGuidelinesRoute(
                            communityId: widget.communityId,
                            userId: widget.userId,
                          ).push(context);
                        },
                        label: const Text("Add Community Guidelines"),
                      ),
                    )
                  : Column(
                      children: widget.guidelines.map((rule) {
                        final index = widget.guidelines.indexOf(rule) + 1;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primaryContainer,
                              child: Text(
                                index.toString(),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(rule, style: Theme.of(context).textTheme.bodyLarge),
                          ),
                        );
                      }).toList(),
                    ),

              const SizedBox(height: 24),

              // Moderator-only: Add more guidelines button
              if (widget.isModerator)
                Center(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      AddCommunityGuidelinesRoute(
                        communityId: widget.communityId,
                        userId: widget.userId,
                      ).push(context);
                    },
                    label: const Text("Add More Community Guidelines"),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
