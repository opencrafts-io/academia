import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EssentialsInstitutionSection extends StatelessWidget {
  const EssentialsInstitutionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstitutionBloc, InstitutionState>(
      builder: (context, state) {
        if (state is InstitutionLoadedState) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final institution = state.institutions[index];
              return _InstitutionCard(institution: institution);
            },
            itemCount: state.institutions.length,
          );
        }

        if (state is InstitutionLoadingState) {
          return Skeletonizer(
            enabled: true,
            child: Card.filled(
              child: ListTile(
                title: Text("Hogwart's School"),
                subtitle: Text("https://some-dummy-institution.ac.ke"),
                trailing: Icon(Icons.open_in_new),
                leading: Icon(Icons.school),
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

class _InstitutionCard extends StatelessWidget {
  const _InstitutionCard({required this.institution});
  final Institution institution;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ListTile(
        onTap: () {},
        leading: Icon(Icons.school),
        title: Text(institution.name),
        subtitle: Text(institution.domains?.first ?? ''),
        trailing: Icon(Icons.open_in_new),
      ),
    );
  }
}
