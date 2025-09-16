import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProfileInstitutionSection extends StatelessWidget {
  const ProfileInstitutionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstitutionBloc, InstitutionState>(
      builder: (context, state) {
        if (state is InstitutionLoadedState) {
          return SliverPadding(
            padding: EdgeInsetsGeometry.all(12),
            sliver: SliverList.builder(
              itemCount: state.institutions.length,
              itemBuilder: (context, index) {
                if (state.institutions.isEmpty) {
                  return Text("Please refresh to fetch your institutions");
                }
                final ins = state.institutions[index];
                return Card.filled(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  child: ListTile(
                    title: Text(ins.name),
                    subtitle: Text(ins.webPages?.first ?? ''),
                  ),
                );
              },
            ),
          );
        } else if (state is InstitutionErrorState) {
          return SliverPadding(
            padding: EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(child: Text(state.error)),
          );
        }

        ///TODO: (erick) add loading indicator
        return MultiSliver(
          children: [Text("Please add institutions to get started")],
        );
      },
    );
  }
}
