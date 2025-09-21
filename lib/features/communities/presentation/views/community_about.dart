import 'package:academia/config/router/routes.dart';
import 'package:flutter/material.dart';

class CommunityAbout extends StatefulWidget {
  final bool isModerator;
  final String communityId;

  const CommunityAbout({
    super.key,
    this.isModerator = false,
    required this.communityId,
  });

  @override
  State<CommunityAbout> createState() => _CommunityAboutState();
}

class _CommunityAboutState extends State<CommunityAbout> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Hardcoded sample guidelines for now
    final guidelines = [
      "Be respectful to all members.",
      "No spam, self-promotion, or irrelevant links.",
      "Use appropriate language at all times.",
      "Report any issues to the moderators.",
      "Stay on-topic and contribute meaningfully.",
    ];

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
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),

              // Guidelines list
              guidelines.isEmpty && widget.isModerator
                  ? Center(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      AddCommunityGuidelinesRoute(communityId: widget.communityId).push(context);
                    },
                    label: const Text("Add Community Guidelines"),
                  ),
                )
                  : Column(
                      children: guidelines.map((rule) {
                        final index = guidelines.indexOf(rule) + 1;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  theme.colorScheme.primaryContainer,
                              child: Text(
                                index.toString(),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(rule, style: theme.textTheme.bodyLarge),
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
                      AddCommunityGuidelinesRoute(communityId: widget.communityId).push(context);
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
