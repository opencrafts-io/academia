import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:intl/intl.dart';

class LeaderboardHomepage extends StatefulWidget {
  const LeaderboardHomepage({super.key});

  @override
  State<LeaderboardHomepage> createState() => _LeaderboardHomepageState();
}

class _LeaderboardHomepageState extends State<LeaderboardHomepage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPinnedHeader(
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Global League",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverList.builder(
            itemCount: 10000,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 4),
                title: Text(
                  "$index. Erick",
                  style: Theme.of(context).listTileTheme.titleTextStyle
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                leading: CircleAvatar(),
                trailing: Text(
                  NumberFormat.compact().format(Random(index).nextInt(5000000)),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
