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
    return Scaffold(
      body: Center(
        child: FilledButton.icon(
          icon: const Icon(Icons.add),
          onPressed: () {
            AddCommunityGuidelinesRoute(
              communityId: widget.communityId,
            ).push(context);
          },
          label: const Text("Add Community Guidelines"),
        ),
      ),
    );
  }
}
