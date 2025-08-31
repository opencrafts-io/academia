import 'package:flutter/material.dart';

class CommunityMembers extends StatefulWidget {
  const CommunityMembers({super.key});

  @override
  State<CommunityMembers> createState() => _CommunityMembersState();
}

class _CommunityMembersState extends State<CommunityMembers> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Community Members Page"),
      ),
    );
  }
}