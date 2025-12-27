import 'package:academia/config/router/router.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class EssentialsInstitutionSection extends StatelessWidget {
  const EssentialsInstitutionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Card.outlined(child: ListTile(title: Text("Hello"))),
      ),
    );
  }
}
