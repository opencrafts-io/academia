import 'package:flutter/material.dart';

class CommunityMembersPage extends StatefulWidget {
  final int communityID;
  final String role;

  const CommunityMembersPage({
    super.key,
    required this.communityID,
    required this.role,
  });

  @override
  State<CommunityMembersPage> createState() => _CommunityMembersPageState();
}

class _CommunityMembersPageState extends State<CommunityMembersPage> {
  String getTitle() {
    if (widget.role == "member") {
      return "Community Members";
    } else if (widget.role == "mod") {
      return "Community Moderators";
    } else if (widget.role == "banned") {
      return "Banned Users";
    }
    return "Community Memberships";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [SliverAppBar(title: Text(getTitle()))]),
    );
  }
}
