import 'package:flutter/material.dart';

class CommunityAbout extends StatefulWidget {
  final bool isModerator;

  const CommunityAbout({super.key, this.isModerator = false});

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
          onPressed: () {},
          label: const Text("Add Community Guidelines"),
        ),
      ),
    );
  }
}
