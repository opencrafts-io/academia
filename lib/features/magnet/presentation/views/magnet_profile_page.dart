import 'package:flutter/material.dart';

class MagnetProfilePage extends StatefulWidget {
  const MagnetProfilePage({super.key, required this.institutionID});
  final int institutionID;

  @override
  State<MagnetProfilePage> createState() => _MagnetProfilePageState();
}

class _MagnetProfilePageState extends State<MagnetProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              snap: true,
              pinned: true,
              floating: true,
              title: Text("Your Profile"),
              actions: [],
            ),

            // SliverPadding(
            //   padding: EdgeInsets.all(12),
            //   sliver: MultiSliver(children: [SizedBox(height: 22)]),
            // ),
          ],
        ),
      ),
    );
  }
}
