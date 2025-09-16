import 'package:flutter/material.dart';

class CommunityAbout extends StatefulWidget {
  const CommunityAbout({super.key});

  @override
  State<CommunityAbout> createState() => _CommunityAboutState();
}

class _CommunityAboutState extends State<CommunityAbout> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Community About Page"),
      ),
    );
  }
}