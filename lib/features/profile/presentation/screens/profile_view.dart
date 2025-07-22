import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text("Hi, Erick!")),

          SliverToBoxAdapter(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(12),
                constraints: BoxConstraints(maxWidth: 1200),
                child: Column(
                  spacing: 12,
                  children: [
                    UserAvatar(radius: 60),
                    Text(
                      "Erick Muuo",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
