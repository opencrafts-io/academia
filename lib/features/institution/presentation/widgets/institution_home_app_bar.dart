import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InstitutionHomeAppBar extends StatelessWidget {
  const InstitutionHomeAppBar({super.key, required this.institutionID});

  final int institutionID;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstitutionBloc, InstitutionState>(
      builder: (context, state) => SliverAppBar.large(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          state.maybeWhen(
            loaded: (institutions) => institutions
                .firstWhere((ins) => ins.institutionId == institutionID)
                .name,
            orElse: () => "#Error",
          ),
        ),
      ),
    );
  }
}
